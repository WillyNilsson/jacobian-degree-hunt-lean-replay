# Exact GitHub CI replay for the Jacobian degree-hunt Lean bundle

This repository replays the complete Lean bundle on Ubuntu, avoiding
the Windows Smart App Control failure encountered locally.

Pinned inputs:

- Lean: `leanprover/lean4:v4.33.0-rc1`
- Mathlib: `4608056c77c52468b80773e8dcd585ef821c7c5e`
- `DegreeHunt.lean` SHA-256:
  `4E0DD6F3E7C4AE7E723F6E2E771C70B2BF89D4CE27D5CB960B3922A175F24B91`
- `DegreeHuntMathlib.lean` SHA-256:
  `B29D8CB61C9CA0EE0D8C675656808A6551D2D1B6044F5B63AF1BDBE54A5F3DC4`
- `ParallelLinesNoGo.lean` SHA-256:
  `E3FADD5DDF2E87722C8B473FDBFBB9ABC5B59B4CC63B542A455A40B1E1129D33`
- `DiagonalReduction.lean` SHA-256:
  `9945CCA2BCF482DD07A98F49C7FB71F221AF9C77C493BEE0ED64BA6D525AA6B9`
- `WronskianDischarge.lean` SHA-256:
  `3088126C691D0EB28F7F15F2AFCB1FF32BDD132E646A22EC56810F5862927B1D`
- `RawDeltaBridge.lean` SHA-256:
  `4E0FA3AE29B06B06D3DCB764F729C4C6C1C70EE5295E3F985B088198F6C131B6`

The workflow:

1. rejects changed proof-file bytes;
2. builds all six proof modules with the pinned dependency graph;
3. enables `leanchecker` as a second environment checker and rejects `sorry`;
4. reruns all six files explicitly so their `#print axioms` output is retained;
5. uploads the terminal logs as a GitHub Actions artifact.

`ParallelLinesNoGo.lean` additionally checks the structural Wronskian lemmas,
the two-root vanishing argument, and exact integer-cleared Nullstellensatz
certificates for both normalized coordinate-parallel line families in the
degree-five `t^2` branch.

`DiagonalReduction.lean` encodes all 25 raw nonconstant coefficients of
`Delta - 1` (the search's 20 equations plus the five triangular equations),
proves covariance under the determinant-one diagonal change, derives both
normalized certificate systems, and supplies end-to-end algebraically closed
field theorems. The public replay kernel-checks these theorems without
`sorryAx`; the displayed axioms are `propext`, `Classical.choice`, and
`Quot.sound`.

`WronskianDischarge.lean` removes the remaining assumed coefficient
vanishings. From `RawSystem` plus each quadratic root equation it derives the
contracted-line Wronskian identities by exact polynomial combinations, proves
the derivative is nonzero at two distinct roots, invokes the quadratic/cubic
Wronskian lemmas, and feeds the resulting vanishings into the diagonal
normalization theorems. Its final theorems are
`parallel_v_from_raw_distinct_roots` and
`parallel_t_from_raw_distinct_roots`.

`RawDeltaBridge.lean` closes the final definitional boundary. It defines the
displayed `alpha`, `beta`, and `gamma` as genuine bivariate `MvPolynomial`s,
defines `Delta` from formal partial derivatives, proves the complete symbolic
expansion `Delta - 1 = rawPolynomial`, and proves
`RawSystem x ↔ Delta x = 1` by coefficient projection. The final theorems
`parallel_v_from_delta_distinct_roots` and
`parallel_t_from_delta_distinct_roots` therefore start from the internally
defined determinant equation rather than an externally generated equation
list.

To use it, create an empty GitHub repository, place these files at its root,
commit, and push to `main`. The workflow also supports manual reruns through
the Actions tab (`workflow_dispatch`).
