# Codex replay of the supplied missing components

Environment: Python 3.12, SymPy 1.14.0, July 21, 2026.

`gl2_witnesses_fable.py` completed with:

```text
GL2 covariance (symbolic coefficients, exact rational M,N, 2 instances): True
nondegenerate factorization witness (mod s^2 = disc): True
degenerate square witness (uses c02 = c11^2/(4 c20)): True
```

Because the originating script used only two rational matrix instances, Codex
replaced that check with `scripts/verify_gl2_and_conic_witnesses.py`.  Its fully
symbolic replay reports:

```text
fully_symbolic_GL2_covariance=True
line_witnesses=True
split_quadratic_witness=True
nondegenerate_residual_normal_forms=True
degenerate_parabola_witness=True
```

`endpoint_certificates_fable.py` was allowed to run for 120 seconds and
reported:

```text
Keller coefficient equations: 14
case (0,1): modular unit: True
  exact Q unit: True
case (1,p): modular unit: True
```

The process timed out while starting the exact symbolic-`p` computation.  That
last computation is not used: full GL₂ conjugation sends every nonzero
collision vector to one fixed vector.

`scripts/endpoint_fixed_collision.py` independently regenerated that single
fixed-vector system and completed exactly:

```text
equations=14 variables=12 sha256=ec0c43f09dbedfa5d4734c9f96a12e1af946627843a39f6cd1b7b8062e81c935
unit_ideal_over_QQ=True
```

The generated Singular input was regenerated a second time and matched
byte-for-byte.  Public run `29869875334` then extracted the Singular lift and
independently replayed it.  The preserved dump has SHA-256
`e64ecc703e95b0a1fa1c9e880bdf48f7900fcc6a1fc2f2538e3f719ba5843155`;
the rational witness has digest
`f9288a9e1c1e06f9ff775bece4b37fdfbd739218bcebe8c3ef04bf02756d8e12`.
The generated `ConstantGammaE2.lean` module subsequently compiled locally with
no `sorryAx` or project-specific axiom.
