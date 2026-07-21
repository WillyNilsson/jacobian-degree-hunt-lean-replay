# Mixed-gamma full-formalization status

The files compiled by the `FullLeanFormalization` Lake target establish two
kernel-checked layers:

- exact Nullstellensatz identities for the six canonical case systems; and
- the full-cubic, `a03`/`b03`-inclusive equivalence
  `RawSystem x ↔ delta x = 1` with all 27 nonconstant coefficients.

The files under `TODO/` are theorem maps supplied with the handoff. They are
deliberately named `*.lean.todo`, are not compiled, and still contain explicit
`sorry` placeholders. In particular, this branch does **not** yet kernel-check:

1. the complete GL₂ normal-form classification;
2. derivation of each certificate system from the literal determinant and the
   appropriate contracted-curve/Wronskian equations;
3. the nonconstant-gamma case dispatch;
4. the formalized constant-gamma invertibility endpoint (the mathematics now
   reduces to one exact fixed-collision unit ideal, but its lift witness and
   Lean conjugation/bridge proofs are not yet present); or
5. the final scaffold theorem assembled only from the original hypotheses.

No claim of an end-to-end Lean formalization should be made until those files
are replaced by ordinary `.lean` modules, included in a Lake target, compiled,
and shown free of `sorryAx` and project-specific axioms.
