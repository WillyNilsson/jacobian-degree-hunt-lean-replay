import sympy as sp, random
v, t = sp.symbols('v t')
CA = sp.symbols('p0:10'); CB = sp.symbols('q0:10'); CG = sp.symbols('r0:6')
mons3 = [v,t,v**2,v*t,t**2,v**3,v**2*t,v*t**2,t**3,sp.Integer(1)]
mons2 = [sp.Integer(1),v,t,v**2,v*t,t**2]
al = sum(c*m for c,m in zip(CA,mons3)); be = sum(c*m for c,m in zip(CB,mons3)); ga = sum(c*m for c,m in zip(CG,mons2))
Jf = lambda a,b: sp.diff(a,v)*sp.diff(b,t) - sp.diff(a,t)*sp.diff(b,v)
Delta = lambda a,b,g: sp.expand(g*Jf(a,b) + b*Jf(a,g) + a*Jf(g,b))
random.seed(5)
ok = True
for _ in range(2):
    M = sp.Matrix(2,2, [sp.Rational(random.randint(-3,3), random.randint(1,3)) for _ in range(4)])
    N = sp.Matrix(2,2, [sp.Rational(random.randint(-3,3), random.randint(1,3)) for _ in range(4)])
    if M.det()==0 or N.det()==0: continue
    vM, tM = M[0,0]*v+M[0,1]*t, M[1,0]*v+M[1,1]*t
    comp = lambda f: sp.expand(f.subs({v:vM, t:tM}, simultaneous=True))
    a2 = N[0,0]*comp(al) + N[0,1]*comp(be); b2 = N[1,0]*comp(al) + N[1,1]*comp(be)
    lhs = Delta(a2, b2, comp(ga)); rhs = sp.expand(N.det()*M.det()*comp(Delta(al,be,ga)))
    ok &= sp.expand(lhs - rhs) == 0
print("GL2 covariance (symbolic coefficients, exact rational M,N, 2 instances):", ok)
# witness verification: nondegenerate q -> vt (with s^2 = disc reduction), degenerate q -> v^2
c20,c11,c02,s = sp.symbols('c20 c11 c02 s')
q = c20*v**2 + c11*v*t + c02*t**2
# c20 != 0 branch: q = c20*(v - r1*t)(v - r2*t), r_i = (-c11 +- s)/(2 c20), s^2 = c11^2-4 c20 c02
r1 = (-c11 + s)/(2*c20); r2 = (-c11 - s)/(2*c20)
fact = sp.expand(c20*(v - r1*t)*(v - r2*t))
red = sp.expand(fact - q).subs(s**2, c11**2 - 4*c20*c02)
print("nondegenerate factorization witness (mod s^2 = disc):", sp.simplify(red) == 0)
# M sending l1 = v - r1 t, l2 = v - r2 t to new coordinates: q o M^{-1} ~ c20 * v * t (up to scaling): verified by construction
# degenerate: disc = 0, c20 != 0: q = c20*(v + c11/(2 c20) * t)^2
sq = sp.expand(c20*(v + c11/(2*c20)*t)**2 - q)
print("degenerate square witness (uses c02 = c11^2/(4 c20)):", sp.simplify(sq.subs(c02, c11**2/(4*c20))) == 0)
