import sympy as sp
v, t, p = sp.symbols('v t p')
Aa = sp.symbols('a20 a11 a02 a30 a21 a12 a03'); Bb = sp.symbols('b20 b11 b02 b30 b21 b12 b03')
a20,a11,a02,a30,a21,a12,a03 = Aa; b20,b11,b02,b30,b21,b12,b03 = Bb
alpha = v + a20*v**2 + a11*v*t + a02*t**2 + a30*v**3 + a21*v**2*t + a12*v*t**2 + a03*t**3
beta  = t + b20*v**2 + b11*v*t + b02*t**2 + b30*v**3 + b21*v**2*t + b12*v*t**2 + b03*t**3
Jac = sp.expand(sp.diff(alpha,v)*sp.diff(beta,t) - sp.diff(alpha,t)*sp.diff(beta,v))
Jeqs = [sp.expand(c) for c in sp.Poly(Jac - Jac.subs({v:0,t:0}), v, t).coeffs()]
Jeqs = [e for e in Jeqs if e != 0]
print("Keller coefficient equations:", len(Jeqs))
# Case (ii): collision pair {(0,1),(0,0)} after torus normalization
sub2 = sp.solve([alpha.subs({v:0,t:1}), beta.subs({v:0,t:1})], [a02, b02])
eqs2 = [sp.expand(e.subs(sub2)) for e in Jeqs]
unk2 = [a20,a11,a30,a21,a12,a03,b20,b11,b30,b21,b12,b03]
G2 = sp.groebner([e for e in eqs2 if e != 0], *unk2, order='grevlex', modulus=32003)
u2 = list(G2.exprs)==[1]
print(f"case (0,1): modular unit: {u2}")
if u2:
    Gq = sp.groebner([e for e in eqs2 if e != 0], *unk2, order='grevlex')
    print("  exact Q unit:", list(Gq.exprs)==[1])
# Case (i): collision pair {(1,p),(0,0)}
eqs1 = Jeqs + [sp.expand(alpha.subs({v:1,t:p})), sp.expand(beta.subs({v:1,t:p}))]
unk1 = list(Aa) + list(Bb) + [p]
G1 = sp.groebner(eqs1, *unk1, order='grevlex', modulus=32003)
u1 = list(G1.exprs)==[1]
print(f"case (1,p): modular unit: {u1}" + ("" if u1 else f" | GB size {len(G1.exprs)}"))
if u1:
    Gq1 = sp.groebner(eqs1, *unk1, order='grevlex')
    print("  exact Q unit:", list(Gq1.exprs)==[1])
