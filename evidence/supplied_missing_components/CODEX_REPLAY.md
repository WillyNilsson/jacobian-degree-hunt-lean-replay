# Codex replay of the supplied missing components

Environment: Python 3.12, SymPy 1.14.0, July 21, 2026.

`gl2_witnesses_fable.py` completed with:

```text
GL2 covariance (symbolic coefficients, exact rational M,N, 2 instances): True
nondegenerate factorization witness (mod s^2 = disc): True
degenerate square witness (uses c02 = c11^2/(4 c20)): True
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
byte-for-byte.  Public Singular lift extraction and independent witness replay
are defined in `.github/workflows/constant-gamma-endpoint.yml`.
