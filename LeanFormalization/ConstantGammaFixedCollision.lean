import LeanFormalization.FullCubicScaffold
import LeanFormalization.Certificates.ConstantGammaE2

/-!
# Constant-gamma fixed-collision bridge

This file connects the literal 27-coefficient determinant system to the exact
Nullstellensatz certificate for a normalized collision at `e₂ = (0,1)`.
It does not yet formalize the affine/GL₂ reduction of an arbitrary collision to
that fixed vector.
-/

namespace MixedGammaFull.ConstantGamma

open FullCubicScaffold

variable {K : Type*} [Field K] [CharZero K]

set_option maxHeartbeats 8000000

/-- A constant-gamma normalized cubic Keller pair cannot vanish at both the
origin and `e₂`.  The two final hypotheses are exactly
`alpha(0,1)=0` and `beta(0,1)=0` in coefficient form. -/
theorem fixed_collision_impossible
    (x : Coefficients K)
    (hc10 : x.c10 = 0) (hc01 : x.c01 = 0)
    (hc20 : x.c20 = 0) (hc11 : x.c11 = 0) (hc02 : x.c02 = 0)
    (hDelta : delta x = 1)
    (hAlphaE2 : x.a02 + x.a03 = 0)
    (hBetaE2 : 1 + x.b02 + x.b03 = 0) : False := by
  have hraw : RawSystem x := (rawSystem_iff_delta_eq_one x).2 hDelta
  have ha02 : x.a02 = -x.a03 := by linear_combination hAlphaE2
  have hb02 : x.b02 = -1 - x.b03 := by linear_combination hBetaE2

  have h1 : MixedGammaCertificates.ConstantGammaE2.e1
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e40
    simp [FullCubicScaffold.e40, hc10, hc01, hc20, hc11, hc02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e1
    linear_combination h
  have h2 : MixedGammaCertificates.ConstantGammaE2.e2
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e31
    simp [FullCubicScaffold.e31, hc10, hc01, hc20, hc11, hc02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e2
    linear_combination h
  have h3 : MixedGammaCertificates.ConstantGammaE2.e3
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e30
    simp [FullCubicScaffold.e30, hc10, hc01, hc20, hc11, hc02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e3
    linear_combination h
  have h4 : MixedGammaCertificates.ConstantGammaE2.e4
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e22
    simp [FullCubicScaffold.e22, hc10, hc01, hc20, hc11, hc02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e4
    linear_combination h
  have h5 : MixedGammaCertificates.ConstantGammaE2.e5
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e21
    simp [FullCubicScaffold.e21, hc10, hc01, hc20, hc11, hc02, ha02, hb02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e5
    linear_combination h
  have h6 : MixedGammaCertificates.ConstantGammaE2.e6
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e20
    simp [FullCubicScaffold.e20, hc10, hc01, hc20, hc11, hc02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e6
    linear_combination h
  have h7 : MixedGammaCertificates.ConstantGammaE2.e7
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e13
    simp [FullCubicScaffold.e13, hc10, hc01, hc20, hc11, hc02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e7
    linear_combination h
  have h8 : MixedGammaCertificates.ConstantGammaE2.e8
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e12
    simp [FullCubicScaffold.e12, hc10, hc01, hc20, hc11, hc02, ha02, hb02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e8
    linear_combination h
  have h9 : MixedGammaCertificates.ConstantGammaE2.e9
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e11
    simp [FullCubicScaffold.e11, hc10, hc01, hc20, hc11, hc02, ha02, hb02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e9
    linear_combination h
  have h10 : MixedGammaCertificates.ConstantGammaE2.e10
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e10
    simp [FullCubicScaffold.e10, hc10, hc01, hc20, hc11, hc02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e10
    linear_combination h
  have h11 : MixedGammaCertificates.ConstantGammaE2.e11
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e04
    simp [FullCubicScaffold.e04, hc10, hc01, hc20, hc11, hc02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e11
    linear_combination h
  have h12 : MixedGammaCertificates.ConstantGammaE2.e12
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e03
    simp [FullCubicScaffold.e03, hc10, hc01, hc20, hc11, hc02, ha02, hb02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e12
    linear_combination h
  have h13 : MixedGammaCertificates.ConstantGammaE2.e13
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e02
    simp [FullCubicScaffold.e02, hc10, hc01, hc20, hc11, hc02, ha02, hb02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e13
    linear_combination h
  have h14 : MixedGammaCertificates.ConstantGammaE2.e14
      x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
      x.b20 x.b11 x.b30 x.b21 x.b12 x.b03 = 0 := by
    have h := hraw.e01
    simp [FullCubicScaffold.e01, hc10, hc01, hc20, hc11, hc02, hb02] at h
    unfold MixedGammaCertificates.ConstantGammaE2.e14
    linear_combination h

  exact MixedGammaCertificates.ConstantGammaE2.no_solution
    x.a20 x.a11 x.a30 x.a21 x.a12 x.a03
    x.b20 x.b11 x.b30 x.b21 x.b12 x.b03
    h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14

#print axioms fixed_collision_impossible

end MixedGammaFull.ConstantGamma
