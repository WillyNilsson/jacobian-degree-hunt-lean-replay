import Lake
open Lake DSL

package DegreeHuntReplay

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @
  "4608056c77c52468b80773e8dcd585ef821c7c5e"

@[default_target]
lean_lib DegreeHuntReplay where
  roots := #[`DegreeHunt, `DegreeHuntMathlib, `ParallelLinesNoGo,
    `DiagonalReduction, `WronskianDischarge, `DegreeHuntReplay]
