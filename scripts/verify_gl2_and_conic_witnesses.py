#!/usr/bin/env python3
"""Symbolically verify GL2 covariance and explicit conic normal-form witnesses."""

from __future__ import annotations

import sympy as sp


def jac(fv: sp.Expr, ft: sp.Expr, gv: sp.Expr, gt: sp.Expr) -> sp.Expr:
    return fv * gt - ft * gv


def verify_covariance() -> None:
    a, b, g = sp.symbols("a b g")
    av, at, bv, bt, gv, gt = sp.symbols("av at bv bt gv gt")
    m11, m12, m21, m22 = sp.symbols("m11 m12 m21 m22")
    n11, n12, n21, n22 = sp.symbols("n11 n12 n21 n22")
    M = sp.Matrix([[m11, m12], [m21, m22]])
    N = sp.Matrix([[n11, n12], [n21, n22]])

    # Row gradients transform by right multiplication with M.
    da = sp.Matrix([[av, at]]) * M
    db = sp.Matrix([[bv, bt]]) * M
    dg = sp.Matrix([[gv, gt]]) * M
    a2 = n11 * a + n12 * b
    b2 = n21 * a + n22 * b
    da2 = n11 * da + n12 * db
    db2 = n21 * da + n22 * db

    delta = g * jac(av, at, bv, bt) + b * jac(av, at, gv, gt) + a * jac(gv, gt, bv, bt)
    transformed = (
        g * jac(da2[0, 0], da2[0, 1], db2[0, 0], db2[0, 1])
        + b2 * jac(da2[0, 0], da2[0, 1], dg[0, 0], dg[0, 1])
        + a2 * jac(dg[0, 0], dg[0, 1], db2[0, 0], db2[0, 1])
    )
    assert sp.expand(transformed - M.det() * N.det() * delta) == 0
    print("fully_symbolic_GL2_covariance=True")


def verify_normal_forms() -> None:
    V, T = sp.symbols("V T")
    a, b = sp.symbols("a b", nonzero=True)

    # Line a*v+b*t: choose M with [a,b]M=[1,0].
    M_line_a = sp.Matrix([[1 / a, -b / a], [0, 1]])
    assert sp.simplify((sp.Matrix([[a, b]]) * M_line_a) - sp.Matrix([[1, 0]])) == sp.zeros(1, 2)
    M_line_b = sp.Matrix([[0, 1], [1 / b, 0]])
    assert sp.simplify((sp.Matrix([[0, b]]) * M_line_b) - sp.Matrix([[1, 0]])) == sp.zeros(1, 2)

    # Split quadratic c(v-r1*t)(v-r2*t): M=L^-1 sends the factors to V,T.
    c, r1, r2 = sp.symbols("c r1 r2", nonzero=True)
    L = sp.Matrix([[1, -r1], [1, -r2]])
    M_split = sp.simplify(L.inv())
    old = M_split * sp.Matrix([V, T])
    split = sp.expand(c * (old[0] - r1 * old[1]) * (old[0] - r2 * old[1]))
    assert sp.simplify(split - c * V * T) == 0
    assert sp.simplify(M_split.det() - 1 / (r1 - r2)) == 0

    # Normalize c*V*T first; then treat the residual linear coefficients.
    A, B = sp.symbols("A B", nonzero=True)
    base = 1 + A * V + B * T + c * V * T
    product_normalized = sp.expand(base.subs({V: V / c, T: T}, simultaneous=True))
    both = sp.expand(product_normalized.subs({V: B * V, T: T / B}, simultaneous=True))
    assert sp.simplify(both - (1 + (A * B / c) * V + T + V * T)) == 0

    only_v = (1 + A * V + V * T).subs({V: V / A, T: A * T}, simultaneous=True)
    assert sp.expand(only_v - (1 + V + V * T)) == 0
    only_t_swapped = (1 + B * T + V * T).subs({V: T, T: V}, simultaneous=True)
    only_t = only_t_swapped.subs({V: V / B, T: B * T}, simultaneous=True)
    assert sp.expand(only_t - (1 + V + V * T)) == 0

    # Square quadratic 1+A*v+B*t+c*v^2 with B!=0.  Choose p with c*p^2=1.
    p = sp.symbols("p", nonzero=True)
    square = 1 + A * V + B * T + c * V**2
    square_normalized = sp.expand(
        square.subs({V: p * V, T: T / B - A * p * V / B}, simultaneous=True).subs(c, 1 / p**2)
    )
    assert sp.simplify(square_normalized - (1 + T + V**2)) == 0

    print("line_witnesses=True")
    print("split_quadratic_witness=True")
    print("nondegenerate_residual_normal_forms=True")
    print("degenerate_parabola_witness=True")


if __name__ == "__main__":
    verify_covariance()
    verify_normal_forms()
