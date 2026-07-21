#!/usr/bin/env python3
"""Extract Singular unit-ideal certificates and emit kernel-checkable Lean files.

Input: directories containing `*_certificate.dump` files from the public
mixed-gamma GitHub Actions artifacts.

For each case the Singular dump contains:
  * the exact QQ polynomial ring and variable order;
  * the complete input ideal I = (e_1, ..., e_n);
  * the first liftstd witness column T with sum_i T_i e_i = 1.

This script independently rechecks that identity with SymPy, clears all rational
denominators, writes canonical JSON, and emits a Lean theorem whose only hard
step is `ring`. The generator itself is not trusted: Lean checks the emitted
polynomial identity.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import re
from dataclasses import dataclass
from fractions import Fraction
from pathlib import Path
from typing import Iterable

import sympy as sp


@dataclass
class Case:
    slug: str
    display: str
    variables: list[str]
    equations: list[sp.Expr]
    witnesses: list[sp.Expr]
    denominator: int
    system_sha256: str
    dump_sha256: str


def split_top_level(text: str) -> list[str]:
    out: list[str] = []
    depth = 0
    start = 0
    for i, ch in enumerate(text):
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
        elif ch == "," and depth == 0:
            out.append(text[start:i].strip())
            start = i + 1
    tail = text[start:].strip()
    if tail:
        out.append(tail)
    return out


def parse_expr(text: str, locals_: dict[str, sp.Symbol]) -> sp.Expr:
    return sp.expand(sp.sympify(text.replace("^", "**"), locals=locals_))


def lcm_denominators(expressions: Iterable[sp.Expr], symbols: list[sp.Symbol]) -> int:
    d = 1
    for expr in expressions:
        poly = sp.Poly(expr, *symbols, domain=sp.QQ)
        for coeff in poly.coeffs():
            d = math.lcm(d, int(sp.denom(coeff)))
    return d


def canonical_system_hash(equations: list[sp.Expr], symbols: list[sp.Symbol]) -> str:
    canonical = [str(sp.Poly(e, *symbols, domain=sp.QQ).as_expr()) for e in equations]
    return hashlib.sha256("\n".join(sorted(canonical)).encode()).hexdigest()


def parse_dump(path: Path) -> Case:
    text = path.read_text(encoding="utf-8")
    ring_match = re.search(r"ring r = \(QQ\),\((.*?)\),\(dp", text, re.S)
    ideal_match = re.search(r"ideal I = ideal\((.*?)\);\s*matrix T", text, re.S)
    matrix_match = re.search(r"matrix T\[\d+\]\[1\] = (.*?);\s*ideal G", text, re.S)
    if not (ring_match and ideal_match and matrix_match):
        raise ValueError(f"Could not parse Singular dump: {path}")

    variables = [v.strip() for v in ring_match.group(1).split(",") if v.strip()]
    symbols = list(sp.symbols(" ".join(variables)))
    if len(variables) == 1:
        symbols = [symbols[0]] if isinstance(symbols, tuple) else [symbols]
    locals_ = dict(zip(variables, symbols))
    equations = [parse_expr(x, locals_) for x in split_top_level(ideal_match.group(1))]
    witnesses = [parse_expr(x, locals_) for x in split_top_level(matrix_match.group(1))]
    if len(equations) != len(witnesses):
        raise ValueError(f"{path}: {len(equations)} equations but {len(witnesses)} witnesses")

    identity = sp.expand(sum(h * e for h, e in zip(witnesses, equations)))
    if identity != 1:
        raise AssertionError(f"Certificate failed for {path}: {identity}")

    denominator = lcm_denominators(witnesses, symbols)
    digest = canonical_system_hash(equations, symbols)
    slug = path.stem.replace("_certificate", "")
    display = {"l": "Line", "q_t": "TAxisQuadratic", "p": "Parabola",
               "h_m": "HyperbolaM", "h_v": "HyperbolaV", "h_0": "Hyperbola0",
               "constant_gamma_e2": "ConstantGammaE2"}.get(slug, slug)
    return Case(
        slug=slug,
        display=display,
        variables=variables,
        equations=equations,
        witnesses=witnesses,
        denominator=denominator,
        system_sha256=digest,
        dump_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
    )


def lean_expr(expr: sp.Expr) -> str:
    # After denominator clearing all coefficients are integers. SymPy's string
    # syntax is almost Lean syntax; only exponentiation differs.
    return sp.sstr(sp.expand(expr), order="lex").replace("**", "^")


def wrap_definition(name: str, vars_text: str, body: str) -> str:
    return f"def {name} ({vars_text}) : K :=\n  {body}\n"


def emit_lean(case: Case) -> str:
    symbols = list(sp.symbols(" ".join(case.variables)))
    if len(case.variables) == 1 and not isinstance(symbols, (tuple, list)):
        symbols = [symbols]
    D = case.denominator
    cleared = [sp.expand(D * h) for h in case.witnesses]
    nonzero = [(i + 1, h) for i, h in enumerate(cleared) if h != 0]
    vars_text = " ".join(case.variables) + " : K"
    namespace = case.display

    lines = [
        "import Mathlib",
        "",
        "/-!",
        f"Automatically generated exact Nullstellensatz replay for `{case.slug}`.",
        f"Canonical system SHA-256: `{case.system_sha256}`.",
        f"Source Singular dump SHA-256: `{case.dump_sha256}`.",
        f"Global denominator cleared: `{D}`.",
        "",
        "The generator independently verified the rational identity before emitting",
        "this file. The mathematical trust boundary is still Lean's `ring` proof.",
        "-/",
        "",
        "namespace MixedGammaCertificates",
        f"namespace {namespace}",
        "",
        "variable {K : Type*} [Field K] [CharZero K]",
        "",
        "set_option maxHeartbeats 8000000",
        "set_option maxRecDepth 200000",
        "",
    ]

    for i, eq in enumerate(case.equations, 1):
        lines.append(wrap_definition(f"e{i}", vars_text, lean_expr(eq)))
    for i, h in nonzero:
        lines.append(wrap_definition(f"w{i}", vars_text, lean_expr(h)))

    args = " ".join(case.variables)
    terms = [f"w{i} {args} * e{i} {args}" for i, _ in nonzero]
    sum_text = "\n      + ".join(terms) if terms else "0"
    # A reduced Singular witness usually uses only a small subset of the input
    # equations.  Lean's `unfold` tactic fails when asked to unfold a constant
    # that is absent from the goal, so keep the proof script aligned with the
    # actual nonzero witness rows.
    unfold_names = [f"e{i}" for i, _ in nonzero] + [f"w{i}" for i, _ in nonzero]
    lines += [
        "/-- Integer-cleared form of the explicit Singular lift certificate. -/",
        f"theorem certificate_identity ({vars_text}) :",
        f"    {sum_text}",
        f"      = ({D} : K) := by",
        "  unfold " + " ".join(unfold_names),
        "  ring",
        "",
        "/-- The displayed case system has no solution over a characteristic-zero field. -/",
        f"theorem no_solution ({vars_text})",
    ]
    for i in range(1, len(case.equations) + 1):
        lines.append(f"    (h{i} : e{i} {args} = 0)")
    lines += [
        "    : False := by",
        f"  have hcert := certificate_identity {' '.join(case.variables)}",
        "  rw [" + ", ".join(f"h{i}" for i, _ in nonzero) + "] at hcert",
        "  norm_num at hcert",
        "",
        "#print axioms certificate_identity",
        "#print axioms no_solution",
        "",
        f"end {namespace}",
        "end MixedGammaCertificates",
        "",
    ]
    return "\n".join(lines)


def case_json(case: Case) -> dict:
    symbols = list(sp.symbols(" ".join(case.variables)))
    if len(case.variables) == 1 and not isinstance(symbols, (tuple, list)):
        symbols = [symbols]
    return {
        "slug": case.slug,
        "display": case.display,
        "variables": case.variables,
        "equation_count": len(case.equations),
        "global_denominator": case.denominator,
        "canonical_system_sha256": case.system_sha256,
        "singular_dump_sha256": case.dump_sha256,
        "equations": [str(e) for e in case.equations],
        "rational_witnesses": [str(h) for h in case.witnesses],
        "integer_cleared_witnesses": [str(sp.expand(case.denominator * h)) for h in case.witnesses],
        "identity": f"sum(integer_cleared_witness_i * equation_i) = {case.denominator}",
        "verified_by_sympy": True,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("artifact_root", type=Path)
    parser.add_argument("output_root", type=Path)
    args = parser.parse_args()

    dumps = sorted(args.artifact_root.rglob("*_certificate.dump"))
    if not dumps:
        raise SystemExit("No *_certificate.dump files found")

    lean_dir = args.output_root / "LeanFormalization" / "Certificates"
    data_dir = args.output_root / "certificate_data"
    lean_dir.mkdir(parents=True, exist_ok=True)
    data_dir.mkdir(parents=True, exist_ok=True)

    cases = [parse_dump(path) for path in dumps]
    for case in cases:
        (lean_dir / f"{case.display}.lean").write_text(emit_lean(case), encoding="utf-8", newline="\n")
        (data_dir / f"{case.slug}.json").write_text(
            json.dumps(case_json(case), indent=2, sort_keys=True), encoding="utf-8", newline="\n"
        )
        print(f"{case.slug}: equations={len(case.equations)} D={case.denominator} sha={case.system_sha256}")

    imports = "\n".join(f"import LeanFormalization.Certificates.{c.display}" for c in cases)
    (args.output_root / "LeanFormalization" / "AllCertificates.lean").write_text(
        imports + "\n", encoding="utf-8", newline="\n"
    )
    manifest = {
        "cases": [case_json(c) | {"equations": None, "rational_witnesses": None,
                                  "integer_cleared_witnesses": None} for c in cases]
    }
    (data_dir / "manifest.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True), encoding="utf-8", newline="\n"
    )


if __name__ == "__main__":
    main()
