import LeanFormalization.FullCubicScaffold

/-!
# Smoothness of the contracted conic

This is the polynomial-level bridge for the singular-conic exclusion.  Under
`Delta = 1`, a zero of `gamma` cannot simultaneously be a zero of both partial
derivatives of `gamma`.
-/

namespace MixedGammaFull.ConicSmoothness

open MvPolynomial FullCubicScaffold

variable {K : Type*} [Field K] [CharZero K]

/-- The contracted curve `gamma = 0` is smooth whenever the normalized Keller
equation `delta = 1` holds. -/
theorem singular_gamma_impossible
    (x : Coefficients K) (hDelta : delta x = 1)
    (p : Fin 2 → K)
    (hcurve : eval p (gamma x) = 0)
    (hGv : eval p (pderiv 0 (gamma x)) = 0)
    (hGt : eval p (pderiv 1 (gamma x)) = 0) : False := by
  have hAtPoint := congrArg (eval p) hDelta
  have hOne : eval p (delta x) = 1 := by simpa using hAtPoint
  have hZero : eval p (delta x) = 0 := by
    unfold delta bracket
    simp [hcurve, hGv, hGt]
  rw [hZero] at hOne
  exact zero_ne_one hOne

#print axioms singular_gamma_impossible

end MixedGammaFull.ConicSmoothness
