"""Independent system generator for the frozen mixed-gamma audit.

This deliberately does not import Fable's scripts and does not use SymPy's
symbolic differentiation/substitution to construct Delta.  Bivariate and
univariate polynomial arithmetic is implemented below with coefficient maps;
SymPy is used only for scalar-expression normalization and Groebner bases.
"""

from __future__ import annotations

import hashlib
import pathlib
import shutil
import sys

_local_sympy = pathlib.Path(__file__).parent / "pydeps114b"
if _local_sympy.exists():
    sys.path.insert(0, str(_local_sympy))
import sympy as sp


def clean(p):
    return {k: sp.expand(v) for k, v in p.items() if sp.expand(v) != 0}


def add(*ps):
    out = {}
    for p in ps:
        for k, value in p.items():
            out[k] = out.get(k, 0) + value
    return clean(out)


def scale(c, p):
    return clean({k: c * value for k, value in p.items()})


def mul(p, q):
    out = {}
    for (i, j), a in p.items():
        for (k, ell), b in q.items():
            key = (i + k, j + ell)
            out[key] = out.get(key, 0) + a * b
    return clean(out)


def deriv(p, axis):
    out = {}
    for (i, j), c in p.items():
        e = i if axis == 0 else j
        if e:
            key = (i - 1, j) if axis == 0 else (i, j - 1)
            out[key] = out.get(key, 0) + e * c
    return clean(out)


def bracket(p, q):
    return add(mul(deriv(p, 0), deriv(q, 1)),
               scale(-1, mul(deriv(p, 1), deriv(q, 0))))


def delta(gamma):
    return add(mul(gamma, bracket(ALPHA, BETA)),
               mul(BETA, bracket(ALPHA, gamma)),
               mul(ALPHA, bracket(gamma, BETA)))


def nonconstant_equations(p):
    return [sp.expand(c) for ij, c in sorted(p.items()) if ij != (0, 0) and c != 0]


def substitute_equations(eqs, substitutions):
    return [q for e in eqs if (q := sp.expand(e.subs(substitutions))) != 0]


def variables(eqs):
    if not eqs:
        return []
    return sorted(set().union(*(e.free_symbols for e in eqs)), key=str)


def system_digest(eqs, gens):
    canonical = []
    for e in eqs:
        p = sp.Poly(e, *gens, domain=sp.QQ)
        canonical.append(str(p.as_expr()))
    payload = "\n".join(sorted(canonical)).encode()
    return hashlib.sha256(payload).hexdigest()


AUDIT_CASES = []


def certify_case(name, eqs, gens=None):
    gens = list(gens or variables(eqs))
    digest = system_digest(eqs, gens)
    basis = sp.groebner(eqs, *gens, order="grevlex")
    unit = list(basis.exprs) == [1]
    print(f"{name}: equations={len(eqs)} variables={len(gens)} "
          f"digest={digest} unit={unit}")
    assert unit
    AUDIT_CASES.append((name, list(eqs), gens, digest))


def singular_expr(expr):
    """Render a QQ polynomial using Singular's exponent syntax."""
    return sp.sstr(sp.expand(expr), order="lex").replace("**", "^")


def write_singular_certificates(output_dir):
    """Emit independent liftstd witness jobs for all audited systems."""
    output_dir.mkdir(parents=True, exist_ok=True)
    for name, eqs, gens, digest in AUDIT_CASES:
        slug = name.lower().replace("-", "_")
        variables_text = ",".join(map(str, gens))
        equations_text = ",\n  ".join(singular_expr(e) for e in eqs)
        script = f'''// Generated independently from coefficient-map arithmetic.
// Case: {name}
// Canonical-system SHA-256: {digest}
ring r=0,({variables_text}),dp;
option(redSB);
ideal I =
  {equations_text};
matrix T;
ideal G=liftstd(I,T);
print("CASE {name}");
print("SYSTEM_SHA256 {digest}");
print("BASIS");
G;
print("UNIT_BASIS_CHECK");
size(G)==1;
G[1]==1;
print("LIFT_IDENTITY_CHECK");
size(module(matrix(G)-matrix(I)*T))==0;
print("CERTIFICATE_MATRIX");
print(T);
dump(":w {slug}_certificate.dump");
$
'''
        (output_dir / f"{slug}.sing").write_text(script, encoding="utf-8", newline="\n")


# Coefficients and the full cubic ansatz.
A = sp.symbols("a20 a11 a02 a30 a21 a12 a03")
B = sp.symbols("b20 b11 b02 b30 b21 b12 b03")
a20, a11, a02, a30, a21, a12, a03 = A
b20, b11, b02, b30, b21, b12, b03 = B
c01, m = sp.symbols("c01 m")

ALPHA = {(1, 0): 1, (2, 0): a20, (1, 1): a11, (0, 2): a02,
         (3, 0): a30, (2, 1): a21, (1, 2): a12, (0, 3): a03}
BETA = {(0, 1): 1, (2, 0): b20, (1, 1): b11, (0, 2): b02,
        (3, 0): b30, (2, 1): b21, (1, 2): b12, (0, 3): b03}


# Lines and the t-only quadratic family.
line_delta = delta({(0, 0): 1, (1, 0): 1})
line_sub = {a03: 0, b03: 0, a12: a02, b12: b02}
line_eqs = substitute_equations(nonconstant_equations(line_delta), line_sub)
line_gens = [a20, a11, a02, a30, a21, b20, b11, b02, b30, b21]
certify_case("L", line_eqs, line_gens)

tquad = {(0, 0): 1, (0, 1): c01, (0, 2): 1}
tquad_sub = {a30: 0, a20: 0, a21: 0, b30: 0, b20: 0, b21: 0}
tquad_eqs = substitute_equations(nonconstant_equations(delta(tquad)), tquad_sub)
tquad_gens = [a11, a02, a12, a03, b11, b02, b12, b03, c01]
certify_case("Q-t", tquad_eqs, tquad_gens)


# Minimal univariate coefficient-map engine for restrictions.
def uadd(*ps):
    out = {}
    for p in ps:
        for k, value in p.items():
            out[k] = out.get(k, 0) + value
    return {k: sp.expand(v) for k, v in out.items() if sp.expand(v) != 0}


def uscale(c, p):
    return {k: sp.expand(c * v) for k, v in p.items() if sp.expand(c * v) != 0}


def umul(p, q):
    out = {}
    for i, a in p.items():
        for j, b in q.items():
            out[i + j] = out.get(i + j, 0) + a * b
    return {k: sp.expand(v) for k, v in out.items() if sp.expand(v) != 0}


def upow(p, n):
    out = {0: 1}
    for _ in range(n):
        out = umul(out, p)
    return out


def uderiv(p):
    return {i - 1: sp.expand(i * c) for i, c in p.items() if i}


def restrict_graph(p, tpoly):
    out = {}
    s_poly = {1: 1}
    for (i, j), c in p.items():
        out = uadd(out, uscale(c, umul(upow(s_poly, i), upow(tpoly, j))))
    return out


parabola = {(0, 0): 1, (0, 1): 1, (2, 0): 1}
psi = {0: -1, 2: -1}
fa = restrict_graph(ALPHA, psi)
fb = restrict_graph(BETA, psi)
conditions = [p.get(k, 0) for p in (fa, fb) for k in range(2, 7) if p.get(k, 0) != 0]
solution = sp.solve(conditions, A + B, dict=True)
assert len(solution) == 1
parabola_eqs = substitute_equations(nonconstant_equations(delta(parabola)), solution[0])
certify_case("P", parabola_eqs)


def clear_restriction(p, numerator, denominator):
    """Return denominator^3 * p(s, numerator/denominator)."""
    out = {}
    s_poly = {1: 1}
    for (i, j), c in p.items():
        mon = umul(upow(s_poly, i),
                   umul(upow(numerator, j), upow(denominator, 3 - j)))
        out = uadd(out, uscale(c, mon))
    return out


def hyperbola_conditions(gamma, numerator, denominator):
    ga = clear_restriction(ALPHA, numerator, denominator)
    gb = clear_restriction(BETA, numerator, denominator)
    wronskian = uadd(umul(ga, uderiv(gb)), uscale(-1, umul(gb, uderiv(ga))))
    target = uadd(wronskian, upow(denominator, 5))
    return [target[k] for k in sorted(target) if target[k] != 0]


hyperbolas = [
    ("H-m", {(0, 0): 1, (1, 0): m, (0, 1): 1, (1, 1): 1},
     {0: -1, 1: -m}, {0: 1, 1: 1}),
    ("H-v", {(0, 0): 1, (1, 0): 1, (1, 1): 1},
     {0: -1, 1: -1}, {1: 1}),
    ("H-0", {(0, 0): 1, (1, 1): 1},
     {0: -1}, {1: 1}),
]

for name, gam, numerator, denominator in hyperbolas:
    full_eqs = nonconstant_equations(delta(gam))
    curve_eqs = hyperbola_conditions(gam, numerator, denominator)
    certify_case(name, full_eqs + curve_eqs)

if len(sys.argv) > 1:
    destination = pathlib.Path(sys.argv[1]).resolve()
    destination.mkdir(parents=True, exist_ok=True)
    shutil.copy2(__file__, destination / pathlib.Path(__file__).name)
    write_singular_certificates(destination / "singular_inputs")
else:
    write_singular_certificates(pathlib.Path(__file__).parent / "singular_inputs")
print("independent coefficient-map regeneration complete")
