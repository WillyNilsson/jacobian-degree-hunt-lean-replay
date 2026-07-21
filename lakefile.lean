import Lake
open Lake DSL

package DegreeHuntReplay

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @
  "4608056c77c52468b80773e8dcd585ef821c7c5e"

@[default_target]
lean_lib DegreeHuntReplay where
  roots := #[`DegreeHunt, `DegreeHuntMathlib, `ParallelLinesNoGo,
    `DiagonalReduction, `WronskianDischarge, `RawDeltaBridge,
    `MixedGammaIdentities, `DegreeHuntReplay]

/- The generated certificate replays and full-cubic bridge are intentionally
kept in a separate, non-default target while the final case wiring remains WIP. -/
lean_lib FullLeanFormalization where
  roots := #[`LeanFormalization.Certificates.ConstantGammaE2,
    `LeanFormalization.Certificates.Hyperbola0,
    `LeanFormalization.Certificates.HyperbolaM,
    `LeanFormalization.Certificates.HyperbolaV,
    `LeanFormalization.Certificates.Line,
    `LeanFormalization.Certificates.Parabola,
    `LeanFormalization.Certificates.TAxisQuadratic,
    `LeanFormalization.ConstantGammaFixedCollision,
    `LeanFormalization.AllCertificates,
    `LeanFormalization.FullCubicScaffold]
