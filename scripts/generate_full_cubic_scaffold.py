#!/usr/bin/env python3
"""Generate the full a03/b03-inclusive determinant bridge for Lean.

The emitted file mirrors RawDeltaBridge.lean but starts from the complete cubic
alpha/beta ansatz. It is generated from a separate SymPy expansion and includes
all 27 nonconstant coefficients of Delta-1 through total degree six.

The file is intentionally delivered as a review/compile candidate: this runtime
has no Lean toolchain, so GitHub CI or local Lean must confirm syntax and tactic
performance before it is added to the default target.
"""

from __future__ import annotations

import json
import re
from pathlib import Path

import sympy as sp

OUT_ROOT = Path(__file__).resolve().parents[1]

v, t = sp.symbols("v t")
field_names = [
    "a20", "a11", "a02", "a30", "a21", "a12", "a03",
    "b20", "b11", "b02", "b30", "b21", "b12", "b03",
    "c10", "c01", "c20", "c11", "c02",
]
S = dict(zip(field_names, sp.symbols(" ".join(field_names))))

alpha = (
    v + S["a20"]*v**2 + S["a11"]*v*t + S["a02"]*t**2
    + S["a30"]*v**3 + S["a21"]*v**2*t + S["a12"]*v*t**2 + S["a03"]*t**3
)
beta = (
    t + S["b20"]*v**2 + S["b11"]*v*t + S["b02"]*t**2
    + S["b30"]*v**3 + S["b21"]*v**2*t + S["b12"]*v*t**2 + S["b03"]*t**3
)
gamma = 1 + S["c10"]*v + S["c01"]*t + S["c20"]*v**2 + S["c11"]*v*t + S["c02"]*t**2


def bracket(p, q):
    return sp.diff(p, v)*sp.diff(q, t) - sp.diff(p, t)*sp.diff(q, v)


delta = sp.expand(gamma*bracket(alpha, beta) + beta*bracket(alpha, gamma) + alpha*bracket(gamma, beta))
assert sp.Poly(delta, v, t).coeff_monomial(1) == 1
remainder = sp.Poly(sp.expand(delta - 1), v, t)
coefficients: list[tuple[int, int, sp.Expr]] = []
for total in range(1, 7):
    for i in range(total + 1):
        j = total - i
        c = sp.expand(remainder.coeff_monomial(v**i*t**j))
        if c != 0:
            coefficients.append((i, j, c))
assert len(coefficients) == 27, len(coefficients)


def lname(i: int, j: int) -> str:
    return f"e{i}{j}"


def lean_scalar(expr: sp.Expr) -> str:
    text = sp.sstr(sp.expand(expr), order="lex").replace("**", "^")
    for name in sorted(field_names, key=len, reverse=True):
        text = re.sub(rf"\b{name}\b", f"x.{name}", text)
    return text


def emit() -> str:
    e_names = [lname(i, j) for i, j, _ in coefficients]
    lines: list[str] = [
        "import Mathlib",
        "import Mathlib.Algebra.MvPolynomial.PDeriv",
        "",
        "/-!",
        "# Full cubic determinant bridge",
        "",
        "Generated review candidate for the complete normalized cubic ansatz,",
        "including the previously omitted `a03*t^3` and `b03*t^3` terms.",
        "It defines the literal bivariate determinant and all 27 nonconstant",
        "coefficients of `Delta - 1`, then states/proves the same coefficient",
        "bridge pattern used successfully in `RawDeltaBridge.lean`.",
        "",
        "This file was generated and algebraically cross-checked with SymPy, but",
        "has not been compiled in the present environment. Keep it outside the",
        "default Lake target until GitHub CI has confirmed it.",
        "-/",
        "",
        "namespace FullCubicScaffold",
        "",
        "open MvPolynomial",
        "",
        "variable {K : Type*} [Field K] [CharZero K]",
        "",
        "set_option maxHeartbeats 8000000",
        "set_option maxRecDepth 200000",
        "",
        "noncomputable section",
        "",
        "structure Coefficients (K : Type*) where",
    ]
    for name in field_names:
        lines.append(f"  {name} : K")
    lines += [
        "",
        "abbrev Bivar (K : Type*) [CommSemiring K] := MvPolynomial (Fin 2) K",
        "",
        "def v : Bivar K := X 0",
        "def t : Bivar K := X 1",
        "",
        "def alpha (x : Coefficients K) : Bivar K :=",
        "  v + C x.a20*v^2 + C x.a11*v*t + C x.a02*t^2",
        "    + C x.a30*v^3 + C x.a21*v^2*t + C x.a12*v*t^2 + C x.a03*t^3",
        "",
        "def beta (x : Coefficients K) : Bivar K :=",
        "  t + C x.b20*v^2 + C x.b11*v*t + C x.b02*t^2",
        "    + C x.b30*v^3 + C x.b21*v^2*t + C x.b12*v*t^2 + C x.b03*t^3",
        "",
        "def gamma (x : Coefficients K) : Bivar K :=",
        "  1 + C x.c10*v + C x.c01*t + C x.c20*v^2 + C x.c11*v*t + C x.c02*t^2",
        "",
        "def bracket (p q : Bivar K) : Bivar K :=",
        "  pderiv 0 p * pderiv 1 q - pderiv 1 p * pderiv 0 q",
        "",
        "def delta (x : Coefficients K) : Bivar K :=",
        "  gamma x * bracket (alpha x) (beta x)",
        "    + beta x * bracket (alpha x) (gamma x)",
        "    + alpha x * bracket (gamma x) (beta x)",
        "",
    ]
    for i, j, expr in coefficients:
        lines += [
            f"def {lname(i,j)} (x : Coefficients K) : K :=",
            f"  {lean_scalar(expr)}",
        ]
    lines += [
        "",
        "structure RawSystem (x : Coefficients K) : Prop where",
    ]
    for name in e_names:
        lines.append(f"  {name} : {name} x = 0")
    lines += [
        "",
        "def term (i j : Nat) (a : K) : Bivar K := C a * v^i * t^j",
        "",
        "def rawPolynomial (x : Coefficients K) : Bivar K :=",
    ]
    terms = [f"term {i} {j} ({lname(i,j)} x)" for i, j, _ in coefficients]
    for idx, term_text in enumerate(terms):
        prefix = "  " if idx == 0 else "    + "
        lines.append(prefix + term_text)
    lines += [
        "",
        "def exponent (i j : Nat) : Fin 2 →₀ Nat :=",
        "  Finsupp.single 0 i + Finsupp.single 1 j",
        "",
        "@[simp] lemma exponent_eq_exponent (i j k l : Nat) :",
        "    exponent i j = exponent k l ↔ i = k ∧ j = l := by",
        "  constructor",
        "  · intro h",
        "    constructor",
        "    · simpa [exponent] using congrArg (fun z => z (0 : Fin 2)) h",
        "    · simpa [exponent] using congrArg (fun z => z (1 : Fin 2)) h",
        "  · rintro ⟨rfl, rfl⟩",
        "    rfl",
        "",
        "lemma term_eq_monomial (i j : Nat) (a : K) :",
        "    term i j a = monomial (exponent i j) a := by",
        "  rw [term, v, t, C_mul_X_pow_eq_monomial, ← monomial_add_single]",
        "  rfl",
        "",
        "private lemma pderiv_v_alpha (x : Coefficients K) :",
        "    pderiv 0 (alpha x) =",
        "      1 + 2*C x.a20*v + C x.a11*t + 3*C x.a30*v^2",
        "        + 2*C x.a21*v*t + C x.a12*t^2 := by",
        "  simp [alpha, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]",
        "  ring",
        "",
        "private lemma pderiv_t_alpha (x : Coefficients K) :",
        "    pderiv 1 (alpha x) =",
        "      C x.a11*v + 2*C x.a02*t + C x.a21*v^2",
        "        + 2*C x.a12*v*t + 3*C x.a03*t^2 := by",
        "  simp [alpha, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]",
        "  ring",
        "",
        "private lemma pderiv_v_beta (x : Coefficients K) :",
        "    pderiv 0 (beta x) =",
        "      2*C x.b20*v + C x.b11*t + 3*C x.b30*v^2",
        "        + 2*C x.b21*v*t + C x.b12*t^2 := by",
        "  simp [beta, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]",
        "  ring",
        "",
        "private lemma pderiv_t_beta (x : Coefficients K) :",
        "    pderiv 1 (beta x) =",
        "      1 + C x.b11*v + 2*C x.b02*t + C x.b21*v^2",
        "        + 2*C x.b12*v*t + 3*C x.b03*t^2 := by",
        "  simp [beta, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]",
        "  ring",
        "",
        "private lemma pderiv_v_gamma (x : Coefficients K) :",
        "    pderiv 0 (gamma x) = C x.c10 + 2*C x.c20*v + C x.c11*t := by",
        "  simp [gamma, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]",
        "  ring",
        "",
        "private lemma pderiv_t_gamma (x : Coefficients K) :",
        "    pderiv 1 (gamma x) = C x.c01 + C x.c11*v + 2*C x.c02*t := by",
        "  simp [gamma, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]",
        "  ring",
        "",
        "theorem delta_sub_one_expansion (x : Coefficients K) :",
        "    delta x - 1 = rawPolynomial x := by",
        "  unfold delta bracket",
        "  rw [pderiv_v_alpha, pderiv_t_alpha, pderiv_v_beta, pderiv_t_beta,",
        "    pderiv_v_gamma, pderiv_t_gamma]",
        "  unfold alpha beta gamma rawPolynomial term v t",
        "  unfold " + " ".join(e_names),
        "  simp only [map_add, map_sub, map_mul, map_neg, map_ofNat]",
        "  ring",
        "",
        "private lemma raw_eq_zero_of_system (x : Coefficients K) (h : RawSystem x) :",
        "    rawPolynomial x = 0 := by",
    ]
    for name in e_names:
        lines.append(f"  have h_{name} : {name} x = 0 := h.{name}")
    simp_names = ", ".join(f"h_{name}" for name in e_names)
    lines += [
        f"  simp [rawPolynomial, {simp_names}, term]",
        "",
        "private lemma raw_coefficient (x : Coefficients K) (i j : Nat) :",
        "    coeff (exponent i j) (rawPolynomial x) =",
    ]
    for idx, (i, j, _) in enumerate(coefficients):
        prefix = "      " if idx == 0 else "      + "
        lines.append(prefix + f"(if i = {i} ∧ j = {j} then {lname(i,j)} x else 0)")
    lines += [
        "    := by",
        "  classical",
        "  simp [rawPolynomial, term_eq_monomial, coeff_monomial, eq_comm]",
        "",
        "private lemma equation_zero_of_raw_zero",
        "    (x : Coefficients K) (hraw : rawPolynomial x = 0)",
        "    (i j : Nat) : coeff (exponent i j) (rawPolynomial x) = 0 := by",
        "  rw [hraw]",
        "  simp",
        "",
        "theorem rawSystem_iff_delta_eq_one (x : Coefficients K) :",
        "    RawSystem x ↔ delta x = 1 := by",
        "  constructor",
        "  · intro h",
        "    apply sub_eq_zero.mp",
        "    rw [delta_sub_one_expansion, raw_eq_zero_of_system x h]",
        "  · intro hdelta",
        "    have hraw : rawPolynomial x = 0 := by",
        "      rw [← delta_sub_one_expansion, hdelta]",
        "      ring",
    ]
    for i, j, _ in coefficients:
        name = lname(i,j)
        lines.append(
            f"    have h_{name} : {name} x = 0 := by "
            f"have hc := equation_zero_of_raw_zero x hraw {i} {j}; "
            "rw [raw_coefficient] at hc; norm_num at hc; exact hc"
        )
    lines += [
        "    exact {",
    ]
    for idx, name in enumerate(e_names):
        comma = "," if idx < len(e_names)-1 else ""
        lines.append(f"      {name} := h_{name}{comma}")
    lines += [
        "    }",
        "",
        "#print axioms delta_sub_one_expansion",
        "#print axioms rawSystem_iff_delta_eq_one",
        "",
        "end",
        "end FullCubicScaffold",
        "",
    ]
    return "\n".join(lines)


lean = emit()
(OUT_ROOT / "LeanFormalization" / "FullCubicScaffold.lean").write_text(lean, encoding="utf-8", newline="\n")
(OUT_ROOT / "certificate_data" / "full_cubic_system.json").write_text(
    json.dumps({
        "field_order": field_names,
        "equation_count": len(coefficients),
        "constant_coefficient": "1",
        "coefficients": [
            {"v_degree": i, "t_degree": j, "name": lname(i,j), "expression": str(expr)}
            for i, j, expr in coefficients
        ],
        "sympy_identity_verified": sp.expand(delta - 1 - sum(expr*v**i*t**j for i,j,expr in coefficients)) == 0,
    }, indent=2, sort_keys=True), encoding="utf-8", newline="\n"
)
print(f"wrote FullCubicScaffold.lean with {len(coefficients)} equations")
