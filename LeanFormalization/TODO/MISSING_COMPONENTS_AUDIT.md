# Audit of the supplied missing components

The originating Fable note and scripts are preserved under
`evidence/supplied_missing_components/`.  They materially improve the handoff,
but the evidence labels need three corrections.

## Accepted

- The four-line GL₂ covariance proof is mathematically sound.  The accompanying
  script is a useful regression check with symbolic polynomial coefficients.
- The displayed hyperbola and parabola parametrizations, density factors, and
  cleared-Wronskian powers agree with the corrected identity
  `W(f₁,f₂) = -h·Delta`.
- The fixed collision `(0,1)` endpoint system is a unit ideal over ℚ.  This was
  replayed independently with SymPy 1.14.0.

## Corrections

1. `gl2_witnesses_fable.py` tests covariance for two exact rational choices of
   M and N; it is not a symbolic proof in the matrix entries.  It checks the
   factor and square identities, but not every advertised normalization matrix,
   residual scaling, inverse, or case transition.
2. The bridge table records the intended consequence chains, not the promised
   term-by-term derivation of every generated certificate equation from the
   literal 27-equation system and the restriction identities.
3. A modular unit ideal for the symbolic `(1,p)` system is not a proof over ℚ.
   Fortunately that computation is unnecessary: full GL₂ conjugation sends any
   nonzero collision vector to `e₂`, leaving only the exact fixed-vector case.

Accordingly the constant-gamma fixed-collision system now has both an exact
Singular lift witness and a kernel-checked Lean certificate.  The Lean
bridge/conjugation and scaffold-injectivity proofs still remain.
