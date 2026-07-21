#!/usr/bin/env python3
"""Generate and replay the constant-gamma fixed-collision system.

Full GL₂ conjugation sends every nonzero collision vector of a normalized
plane Keller pair to e₂ = (0, 1).  This removes the symbolic collision
parameter used in the originating script: only one exact system is needed.

The script independently derives the fourteen nonconstant Jacobian
coefficients, eliminates the two collision equations, checks the resulting
ideal over QQ with SymPy, and can emit a Singular liftstd input for extraction
of a kernel-checkable Nullstellensatz witness.
"""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path

import sympy as sp


def fixed_collision_system() -> tuple[list[sp.Symbol], list[sp.Expr]]:
    v, t = sp.symbols("v t")
    aa = sp.symbols("a20 a11 a02 a30 a21 a12 a03")
    bb = sp.symbols("b20 b11 b02 b30 b21 b12 b03")
    a20, a11, a02, a30, a21, a12, a03 = aa
    b20, b11, b02, b30, b21, b12, b03 = bb

    alpha = (
        v
        + a20 * v**2
        + a11 * v * t
        + a02 * t**2
        + a30 * v**3
        + a21 * v**2 * t
        + a12 * v * t**2
        + a03 * t**3
    )
    beta = (
        t
        + b20 * v**2
        + b11 * v * t
        + b02 * t**2
        + b30 * v**3
        + b21 * v**2 * t
        + b12 * v * t**2
        + b03 * t**3
    )
    jac = sp.expand(sp.diff(alpha, v) * sp.diff(beta, t) - sp.diff(alpha, t) * sp.diff(beta, v))

    # DG(0)=I, hence the constant coefficient of the Jacobian is already one.
    jacobian_equations = [
        sp.expand(coeff)
        for monomial, coeff in sp.Poly(jac - 1, v, t).terms()
        if monomial != (0, 0) and coeff != 0
    ]
    assert len(jacobian_equations) == 14

    # G(0,1)=0 gives a02+a03=0 and 1+b02+b03=0.
    collision_substitution = {a02: -a03, b02: -1 - b03}
    equations = [sp.expand(eq.subs(collision_substitution)) for eq in jacobian_equations]
    equations = [eq for eq in equations if eq != 0]
    variables = [a20, a11, a30, a21, a12, a03, b20, b11, b30, b21, b12, b03]
    return variables, equations


def canonical_digest(variables: list[sp.Symbol], equations: list[sp.Expr]) -> str:
    payload = "variables=" + ",".join(map(str, variables)) + "\n"
    payload += "\n".join(sp.sstr(eq) for eq in equations) + "\n"
    return hashlib.sha256(payload.encode("utf-8")).hexdigest()


def singular_source(variables: list[sp.Symbol], equations: list[sp.Expr], digest: str) -> str:
    singular_equations = [sp.sstr(eq).replace("**", "^") for eq in equations]
    ideal = ",\n  ".join(singular_equations)
    return f"""// Independently generated constant-gamma endpoint system.
// Collision normalized by full GL2 conjugation to e2=(0,1).
// Canonical-system SHA-256: {digest}
ring r=0,({','.join(map(str, variables))}),dp;
option(redSB);
ideal I =
  {ideal};
matrix T;
ideal G=liftstd(I,T);
print(\"CASE CONSTANT_GAMMA_E2\");
print(\"SYSTEM_SHA256 {digest}\");
print(\"RAW_CONSTANT_BASIS\");
G;
number unit_coefficient=leadcoef(G[1]);
T=(1/unit_coefficient)*T;
G=ideal(1);
print(\"UNIT_BASIS_CHECK\");
size(G)==1;
G[1]==1;
print(\"LIFT_IDENTITY_CHECK\");
size(module(matrix(G)-matrix(I)*T))==0;
print(\"CERTIFICATE_MATRIX\");
int certificate_row;
for (certificate_row=1; certificate_row<=nrows(T); certificate_row++)
{{
  print(\"ROW \"+string(certificate_row));
  T[certificate_row,1];
}}
dump(\":w constant_gamma_e2_certificate.dump\");
$
"""


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--emit-singular", type=Path)
    parser.add_argument("--modulus", type=int, default=None)
    args = parser.parse_args()

    variables, equations = fixed_collision_system()
    digest = canonical_digest(variables, equations)
    print(f"equations={len(equations)} variables={len(variables)} sha256={digest}")

    if args.emit_singular:
        args.emit_singular.parent.mkdir(parents=True, exist_ok=True)
        args.emit_singular.write_text(singular_source(variables, equations, digest), encoding="utf-8", newline="\n")
        print(f"wrote {args.emit_singular}")

    basis = sp.groebner(equations, *variables, order="grevlex", modulus=args.modulus)
    unit = list(basis.exprs) == [1]
    domain = f"F_{args.modulus}" if args.modulus else "QQ"
    print(f"unit_ideal_over_{domain}={unit}")
    if not unit:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
