# Mixed-gamma full-formalization status

The files compiled by the `FullLeanFormalization` Lake target establish five
kernel-checked layers:

- exact Nullstellensatz identities for the six canonical nonconstant-gamma
  systems and the constant-gamma fixed-collision system; and
- the full-cubic, `a03`/`b03`-inclusive equivalence
  `RawSystem x ↔ delta x = 1` with all 27 nonconstant coefficients; and
- a direct bridge from the constant-gamma specialization of that raw system
  and a collision at `e₂ = (0,1)` to all fourteen equations used by the
  constant-gamma certificate, hence a kernel-checked contradiction;
- whole-polynomial GL₂ source/target covariance, including the two chain
  rules for linear substitution and preservation of `Delta = 1` when the
  determinant factors cancel; and
- the polynomial-level exclusion of singular contracted conics under
  `Delta = 1`.

The files under `TODO/` are theorem maps supplied with the handoff. They are
deliberately named `*.lean.todo`, are not compiled, and still contain explicit
`sorry` placeholders. In particular, this branch does **not** yet kernel-check:

1. the complete GL₂ normal-form classification (the covariance and
   singular-conic exclusion it uses are now checked);
2. derivation of each certificate system from the literal determinant and the
   appropriate contracted-curve/Wronskian equations;
3. the nonconstant-gamma case dispatch;
4. the complete constant-gamma invertibility endpoint (its fixed-collision
   certificate and raw-system coefficient bridge are now kernel-checked, but
   the Lean translation/renormalization and GL₂ conjugation from an arbitrary
   collision are not yet present); or
5. the final scaffold theorem assembled only from the original hypotheses.

No claim of an end-to-end Lean formalization should be made until those files
are replaced by ordinary `.lean` modules, included in a Lake target, compiled,
and shown free of `sorryAx` and project-specific axioms.
