# How a degree-five hunting ground was ruled out

## A readable account of the mathematics, the certificates, and the Lean audit

The short version is this: a large and natural family of possible
degree-five counterexamples to the Jacobian conjecture has been eliminated.
The result does **not** settle every possible degree-five map. It closes one
specific equivariant construction, called the `(1,-1,-1)` scaffold, that was a
particularly plausible place to search below the known degree-seven example.

The proof combines geometry, exact computer algebra, and formal verification.
Those three layers do different jobs. The geometry reduces infinitely many
quadratic possibilities to a handful of shapes. Computer algebra proves that
each remaining finite equation system is impossible. Lean checks the algebraic
identities and the impossibility certificates without trusting the computer
algebra program that discovered them.

## 1. What is being studied?

A polynomial map has the *Keller property* when its Jacobian determinant is a
nonzero constant. The classical Jacobian problem asks whether that condition
forces the map to be invertible. This project studies maps in three variables
with a built-in scaling symmetry.

For the weight system `(1,-1,-1)`, introduce the invariant combinations

```text
v = xy,    t = xz.
```

The scaffold has the form

```text
F(x,y,z) = (alpha(v,t)/x, beta(v,t)/x, x gamma(v,t)).
```

Here `alpha` and `beta` begin with the linear terms `v` and `t` and have degree
at most three in `(v,t)`. The polynomial `gamma` has degree at most two and
constant term one. These caps make the resulting map have degree at most five.

The three-variable Jacobian determinant collapses to one two-variable
expression:

```text
Delta = gamma {alpha,beta}
      + beta  {alpha,gamma}
      + alpha {gamma,beta},
```

where

```text
{f,g} = f_v g_t - f_t g_v
```

is the two-variable Jacobian bracket. After normalizing the nonzero constant,
the Keller condition is simply `Delta = 1`.

Expanding `Delta - 1` gives 27 nonconstant coefficients. Thus the original
question becomes a concrete system of 27 polynomial equations in the
coefficients of `alpha`, `beta`, and `gamma`.

## 2. Why only a few shapes of gamma matter

At first, a general quadratic `gamma` looks like a five-parameter problem. But
the scaffold is unchanged in essence by an invertible linear transformation of
the `(v,t)` coordinates. A compensating transformation of the `(alpha,beta)`
slots restores their normalized linear terms.

If the source matrix is `M` and the target compensation is `N`, then

```text
Delta_new = det(N) det(M) (Delta composed with M).
```

Choosing the determinant factors to cancel preserves `Delta = 1`. This is not
just a numerical observation: the repository now contains a Lean proof for
the linear substitution chain rules and this full polynomial covariance.

Over an algebraically closed field, ordinary conic classification then reduces
every nonconstant quadratic `gamma` to a short list:

- a line, represented by `1 + v`;
- an axis quadratic;
- a parabola, represented by `1 + t + v^2`;
- three hyperbola forms, including the family
  `1 + m v + t + vt`.

Singular conics, such as crossing or doubled lines, can be excluded directly.
If `gamma`, `gamma_v`, and `gamma_t` vanished at one point, every term in
`Delta` would vanish there, contradicting `Delta = 1`.

## 3. The contracted curve and its Wronskian

The conceptual heart of the proof is the curve `gamma = 0`. Along this curve,
the third coordinate `x gamma` is contracted. Parametrize a branch by
`phi(s)` and suppose its tangent has the form

```text
phi'(s) = h(s) (gamma_t, -gamma_v).
```

Restrict `alpha` and `beta` to the curve:

```text
f1(s) = alpha(phi(s)),    f2(s) = beta(phi(s)).
```

A direct chain-rule calculation gives the sign-correct identity

```text
W(f1,f2) = f1 f2' - f2 f1' = -h Delta(phi(s)).
```

Because `Delta = 1`, the geometry of the conic places a very rigid condition
on the two restricted polynomials.

For a line or graph parabola, `h` is constant. A nonzero constant Wronskian
forces the relevant polynomial restrictions to be affine-linear, so their
higher coefficients vanish. For a hyperbola, the parametrization has a pole.
Multiplying each restricted cubic by the cube of the pole factor clears the
denominators, and the identity becomes

```text
W(g1,g2) = -u^5.
```

This is again a finite list of exact coefficient equations. Lean already
checks the general Wronskian identity, its sign, the smoothness consequence,
and the denominator-clearing formula.

## 4. How the six cases are eliminated

Each normal form supplies two groups of equations:

1. the specialized coefficients of `Delta - 1`; and
2. the coefficient consequences of the Wronskian identity on `gamma = 0`.

For the line and axis cases, the Wronskian forces high-degree restriction
coefficients to vanish. For the parabola, ten such conditions collapse the
remaining ansatz to only four unknowns. For the hyperbolas, the cleared
Wronskian contributes twelve coefficient equations.

In every case, the resulting ideal is the unit ideal over the rationals. That
phrase has a wonderfully concrete meaning. If the equations are
`e1 = 0, ..., en = 0`, there are explicit witness polynomials `h1, ..., hn`
such that

```text
h1 e1 + ... + hn en = 1.
```

If all the `ei` vanished at a proposed solution, the left side would be zero
while the right side would be one. Therefore no solution exists. This is a
Nullstellensatz certificate: a compact, independently checkable proof of
inconsistency, not a floating-point search or a claim that a program found no
answer.

Seven certificate systems are now present: six nonconstant-`gamma` cases and
one constant-`gamma` collision case. Singular produced the witnesses, a
separate parser reconstructed them, SymPy checked the identities over exact
rationals, and generated Lean modules verify the identities again after
clearing denominators.

## 5. What happens when gamma is constant?

When `gamma = 1`, the equation reduces to

```text
{alpha,beta} = 1.
```

So the endpoint is a normalized plane Keller pair of degree at most three.
Instead of citing a classical low-degree theorem, the project uses the same
certificate philosophy.

If such a pair had two equal values, translate one collision point to the
origin, renormalize the derivative there, and use an invertible linear change
to send the other collision vector to `e2 = (0,1)`. In that fixed position the
collision conditions are simply

```text
a02 + a03 = 0,
1 + b02 + b03 = 0.
```

The 14 resulting Jacobian equations form another unit ideal. Lean now starts
from the literal 27-coefficient system, specializes `gamma` to one, derives all
14 certificate equations, and invokes the checked certificate to obtain a
contradiction.

The remaining formalization task here is the general coordinate reduction:
translation, derivative renormalization, and the invertible linear change from
an arbitrary collision to `(0,1)`. The fixed collision itself is completely
connected to the raw determinant equations and kernel-checked.

## 6. What Lean has—and has not—proved

It helps to distinguish four levels of evidence.

### Kernel-checked now

- the determinant and bracket identities underlying the scaffold;
- the full 27-coefficient expansion of `Delta - 1`;
- the pointwise and whole-polynomial linear covariance identities;
- the contracted-curve Wronskian identity and hyperbola denominator clearing;
- exact Nullstellensatz identities for all six nonconstant cases;
- the constant-`gamma` fixed-collision certificate;
- the bridge from the raw determinant equations to that fixed-collision
  certificate.

### Independently exact, but not yet fully wired through Lean

- the complete conic normal-form classification and its explicit matrices;
- the derivation of every nonconstant-case certificate equation from the raw
  equations and the appropriate curve restriction;
- the final case dispatch;
- the arbitrary-collision normalization and final scaffold-injectivity
  assembly.

The public workflow pins the Lean version and the exact Mathlib commit, checks
artifact hashes before use, regenerates the certificate modules, compiles them,
prints theorem axioms, and rejects `sorryAx`. This makes the result
reproducible and prevents a green check from silently referring to different
inputs.

## 7. The precise conclusion

The evidence supports the following restricted theorem:

> In the normalized degree-five `(1,-1,-1)` equivariant scaffold, the Keller
> condition forces `gamma` to be constant, and the constant case has no
> collision. Consequently this scaffold contains no degree-five Jacobian
> counterexample.

This closes a substantial and natural hunting ground. It does **not** prove
that no degree-five counterexample exists in every conceivable form. Other
weight systems, other equivariant patterns, and non-equivariant maps remain
outside the theorem.

The honest current label is therefore:

> Exact conventional proof with independently replayed rational certificates;
> major algebraic layers kernel-checked; final normal-form and case-wiring
> formalization still in progress.

That distinction is not a weakness. It is the point of the adversarial audit:
every sentence says exactly which machine checked which link, and which links
are still owed.

---

## Short social version

We ruled out every degree-five Jacobian counterexample inside the natural
`(1,-1,-1)` equivariant scaffold. Geometry reduces a general quadratic
contracted curve to six conic normal forms; a Wronskian identity turns each
form into exact coefficient constraints; explicit Nullstellensatz certificates
show all six systems are impossible. The certificates, the 27 raw Jacobian
coefficients, the Wronskian identities, the fixed constant-`gamma` endpoint,
and polynomial GL₂ covariance are now Lean-checked under pinned public CI.
This closes the scaffold, not the global degree-five question; the remaining
work is the final normal-form and case-dispatch wiring in Lean.
