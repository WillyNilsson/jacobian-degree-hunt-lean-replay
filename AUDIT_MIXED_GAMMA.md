# Audit of the full mixed-gamma `(1,-1,-1)` scaffold result

Audit date: 2026-07-21.  Scope: the frozen Fable bundle in
`case_studies/jacobian_degree_hunt/mixed_gamma`, the six claimed unit-ideal
computations, and the two new structural identities.  The separate
`(1,-1,-2)` search is not included in this verdict.

## Verdict

The six algebraic exclusions are confirmed.  The originating programs replay
with their stated SymPy 1.14.0 dependency; an independently written
coefficient-map implementation regenerates the six systems; Singular produces
an explicit rational Nullstellensatz witness for every system; and SymPy
independently checks every printed identity

`sum_i h_i * e_i = 1`.

The GL2 covariance, sign-correct parametrized Wronskian identity, singular-curve
smoothness corollary, and hyperbola pole-clearing identity now also have Lean
proofs in `MixedGammaIdentities.lean`.

This establishes the advertised no-solution result at the level of an audited
conventional proof with exact, independently checked certificates.  It is not
yet a single end-to-end Lean theorem for the entire full scaffold: the conic
normal-form classification, the wiring from the full t-cubed-inclusive ansatz
to each certificate system, the six certificates themselves, and the
constant-gamma endpoint are not all inside Lean's kernel.

## Frozen-bundle integrity and replay

The recorded SHA-256 values of the three programs, the mathematical note, and
`run_log.txt` match the files on disk.  The recorded hash of `MANIFEST.md` does
not match: the file records
`9bb7308ba2d6e5a3dcc325679b4500398c452aac316a4890c86f7d4881bda908`,
whereas the frozen file hashes to
`95c7485ab3bd2a99a60aa0ed48b745a0c60a88fc82fd49aeb7d75264e7b8ac6f`.
This is a manifest self-hash defect, not a change in a mathematical input.

All three programs were replayed unchanged under SymPy 1.14.0.  Their equation
counts, reductions, modular checks, exact rational Groebner bases, and printed
unit-ideal results agree with the frozen log.  The parabola program still
prints `W == Delta|curve: False` because that diagnostic uses the old unsigned
formula.  The correct identity is `W = -Delta` on that parametrization.  Only
the vanishing of coefficients of degree at least two is used afterward, so the
sign does not alter its system or conclusion.

## Independent regeneration

The independent generator does not import the originating programs and does
not use symbolic differentiation or substitution to construct Delta.  It uses
sparse bivariate and univariate coefficient maps, then hands the resulting
scalar systems to SymPy and Singular.

| Case | Equations | Variables | Canonical-system SHA-256 |
|---|---:|---:|---|
| line `1+v` | 14 | 10 | `60b820f39e8701a4a057154058bec5eae9fc7f417ee63c6fe9112d13b9f5a7f2` |
| t-axis quadratic | 11 | 9 | `f57c66d593d2eb089a5b75ab1517e41a442df1fdf3889cab91566bb56b5b1a12` |
| parabola `1+t+v^2` | 15 | 4 | `d24e14c9d0db37e5013050ade166a9db44114d52670fdf00f2783c3095f994d1` |
| hyperbola `1+m*v+t+v*t` | 36 | 15 | `a266649de502a2116815fa29d80ed8997f16f0027c70dc9ab1264548c9b2b66c` |
| hyperbola `1+v+v*t` | 36 | 14 | `7d5058bbce36099a1cc87a7ca4d22262d68abaff63878326423ed8d7abab9d2f` |
| hyperbola `1+v*t` | 36 | 14 | `d6da3bbd8a47232b077cf7e5297d5d3489aa5751da174f7e1974ad8de227507e` |

## Exact certificates

The public Singular run is
[GitHub Actions run 29817724979](https://github.com/WillyNilsson/jacobian-degree-hunt-lean-replay/actions/runs/29817724979).
Every matrix job passed.  Singular 4.3.2p10 computed `G=liftstd(I,T)`, the job
normalized its nonzero constant basis element to `1`, and checked the exact
matrix identity `matrix(G)=matrix(I)*T`.

The downloaded first columns of `T` were then parsed and checked independently
over `QQ`.  Their canonical certificate hashes are:

| Case | Certificate SHA-256 | Independent identity |
|---|---|---|
| line | `cdcc18abdf50d3e0c77dbbff324634441ad5ac3bce7fcced2a2088fd02d79611` | true |
| t-axis quadratic | `5534147c6c55e6369f73635640f63d4bd777d0f112e1ea4fc88f31efd010565a` | true |
| parabola | `b2e82ab0278fe0a85a4aedeaef16eab8f6b2f47dc4d5d8b9fa33feddd72b1013` | true |
| symbolic hyperbola | `95d6b02f503608970cb8e2159a94d05d54ec2842f1e272fe4c06c010cf0637d5` | true |
| one-linear hyperbola | `6236252539453db2f6eeb9f2ddd48347def2a367e46b0f37f4d198a6e7609c7d` | true |
| pure hyperbola | `6df0b4fccf621f3e587a27069610da9000f628e61120f287f0ef699cedd4d110` | true |

The CI workflow repeats this second-engine check before uploading its witness,
restorable Singular session, logs, package inventory, and artifact hash list.

## Structural audit

Write `gamma=1+ell+q`, with `q` a binary quadratic form over an algebraically
closed characteristic-zero field.

- If `rank(q)=0`, a nonconstant `gamma` is a line.
- If `rank(q)=1`, put `q=v^2`.  A component of `ell` along the kernel of `q`
  gives the parabola `1+t+v^2`; otherwise `gamma` is an axis quadratic.
- If `rank(q)=2`, put `q=v*t`.  The stabilizer of `v*t`, together with swapping
  the two variables, leaves exactly the three displayed hyperbola types,
  according as both, one, or neither linear coefficient is nonzero.  When both
  are nonzero their product is the remaining parameter `m`.

The member `m=1` factors as `(1+v)(1+t)`.  Crossing lines and double lines are
singular, and the determinant formula vanishes at a singular point of
`gamma=0`; hence they cannot occur when Delta is a nonzero constant.

For `t=-(1+s^2)` the tangent equals the Hamiltonian vector field of `gamma`, so
`h=1`.  For all three rational hyperbola parametrizations the tangent is
`(1/u)` times that vector field.  Therefore

`W(alpha o phi, beta o phi) = -h * Delta`.

If `g_i=u^3 f_i`, the product-rule cross terms cancel and
`W(g_1,g_2)=u^6 W(f_1,f_2)=-Delta*u^5`.  These exact signs and powers agree with
the independently generated systems and the Lean lemmas.

The constant-gamma endpoint reduces to a plane Keller pair of degree at most
three.  Its invertibility is a classical low-degree plane result; for context,
the degree criteria are discussed in
[Zoladek's paper and its historical note](https://www.sciencedirect.com/science/article/pii/S0040938308000207)
and the original coprime-degree argument appears in
[Magnus (1955)](https://www.mscand.dk/article/view/10443).

## Remaining Lean boundary

An end-to-end kernel theorem still needs four explicit pieces:

1. formal classification of `1+ell+q` under GL2 into the canonical cases;
2. a full ansatz including `a03` and `b03`, with coefficient extraction from
   the literal determinant into the six systems;
3. Lean replay of the six printed Nullstellensatz combinations;
4. a formal constant-gamma reduction to the applicable plane degree theorem.

Until those are present, the accurate label is: **independently audited exact
theorem, with its new structural identities Lean-checked; not yet one
end-to-end Lean theorem.**
