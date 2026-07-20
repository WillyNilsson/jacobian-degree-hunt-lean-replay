# Exact GitHub CI replay for the Jacobian degree-hunt Lean bundle

This repository replays the two byte-preserved Lean files on Ubuntu, avoiding
the Windows Smart App Control failure encountered locally.

Pinned inputs:

- Lean: `leanprover/lean4:v4.33.0-rc1`
- Mathlib: `4608056c77c52468b80773e8dcd585ef821c7c5e`
- `DegreeHunt.lean` SHA-256:
  `4E0DD6F3E7C4AE7E723F6E2E771C70B2BF89D4CE27D5CB960B3922A175F24B91`
- `DegreeHuntMathlib.lean` SHA-256:
  `B29D8CB61C9CA0EE0D8C675656808A6551D2D1B6044F5B63AF1BDBE54A5F3DC4`

The workflow:

1. rejects changed proof-file bytes;
2. builds both files with the pinned dependency graph;
3. enables `leanchecker` as a second environment checker and rejects `sorry`;
4. reruns both files explicitly so their `#print axioms` output is retained;
5. uploads the terminal logs as a GitHub Actions artifact.

This checks the older linear-in-`t` theorem. It does not formalize the newer
parallel-line exclusions, which would require a new Lean source file.

To use it, create an empty GitHub repository, place these files at its root,
commit, and push to `main`. The workflow also supports manual reruns through
the Actions tab (`workflow_dispatch`).
