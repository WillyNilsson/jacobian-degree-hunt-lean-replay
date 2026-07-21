import Mathlib

/-!
# Algebraic identities for the mixed-gamma frontier

This file kernel-checks the two identities that organize the full mixed-gamma
case split: covariance of the determinant expression under linear source and
target changes, and the sign-correct contracted-curve Wronskian identity.  It
also checks the cubic-denominator clearing step used for hyperbolas.

The statements are pointwise and algebraic.  The hypotheses named `Av`, `At`,
and so on stand for the corresponding partial derivatives; `Ap` and `Bp`
stand for derivatives along a parametrized curve.  Consequently the file does
not hide any analytic or formal-power-series assumptions.
-/

namespace MixedGammaIdentities

variable {K : Type*} [CommRing K]

/-- The value of the two-variable Poisson bracket from four partial values. -/
def bracketValue (Av At Bv Bt : K) : K := Av * Bt - At * Bv

/-- The determinant expression for the `(1,-1,-1)` scaffold at one point. -/
def deltaValue
    (A B G Av At Bv Bt Gv Gt : K) : K :=
  G * bracketValue Av At Bv Bt
    + B * bracketValue Av At Gv Gt
    + A * bracketValue Gv Gt Bv Bt

/-- The Wronskian of two restrictions and their parameter derivatives. -/
def wronskianValue (A B Ap Bp : K) : K := A * Bp - B * Ap

/-- A linear source change scales the determinant expression by its
determinant.  The convention is
`v_old = p*v_new + q*t_new`, `t_old = r*v_new + s*t_new`. -/
theorem source_linear_covariance
    (p q r s A B G Av At Bv Bt Gv Gt : K) :
    deltaValue A B G
        (p*Av + r*At) (q*Av + s*At)
        (p*Bv + r*Bt) (q*Bv + s*Bt)
        (p*Gv + r*Gt) (q*Gv + s*Gt)
      = (p*s - q*r) * deltaValue A B G Av At Bv Bt Gv Gt := by
  simp only [deltaValue, bracketValue]
  ring

/-- A linear change of the `(alpha,beta)` target slots scales the determinant
expression by its determinant. -/
theorem target_linear_covariance
    (a b c d A B G Av At Bv Bt Gv Gt : K) :
    deltaValue
        (a*A + b*B) (c*A + d*B) G
        (a*Av + b*Bv) (a*At + b*Bt)
        (c*Av + d*Bv) (c*At + d*Bt) Gv Gt
      = (a*d - b*c) * deltaValue A B G Av At Bv Bt Gv Gt := by
  simp only [deltaValue, bracketValue]
  ring

/-- If a curve tangent is `h * (G_t,-G_v)` and lies on `G=0`, then the
Wronskian of the restricted `A,B` pair is `-h*Delta`.  This fixes the sign
that was left unsigned in the earlier parallel-line notes. -/
theorem parametrized_contracted_curve_identity
    (A B G Av At Bv Bt Gv Gt vp tp h Delta Ap Bp : K)
    (hcurve : G = 0)
    (hvp : vp = h * Gt)
    (htp : tp = -h * Gv)
    (hAp : Ap = Av*vp + At*tp)
    (hBp : Bp = Bv*vp + Bt*tp)
    (hDelta : Delta = deltaValue A B G Av At Bv Bt Gv Gt) :
    wronskianValue A B Ap Bp = -h * Delta := by
  rw [hAp, hBp, hDelta, hvp, htp, hcurve]
  simp only [wronskianValue, deltaValue, bracketValue, zero_mul]
  ring

/-- A point of `G=0` cannot also satisfy `G_v=G_t=0` when the determinant
value is nonzero.  This is the smoothness corollary used to remove crossing
and double lines before the computational case split. -/
theorem contracted_curve_is_smooth
    (A B G Av At Bv Bt Gv Gt Delta : K)
    (hcurve : G = 0) (hGv : Gv = 0) (hGt : Gt = 0)
    (hDelta : Delta = deltaValue A B G Av At Bv Bt Gv Gt)
    (hDeltaNe : Delta ≠ 0) : False := by
  apply hDeltaNe
  rw [hDelta, hcurve, hGv, hGt]
  simp [deltaValue, bracketValue]

/-- Multiplying both restricted cubics by `u^3` multiplies their Wronskian by
`u^6`; all product-rule cross terms cancel. -/
theorem cubic_denominator_wronskian
    (u up f1 f2 f1p f2p g1 g2 g1p g2p : K)
    (hg1 : g1 = u^3 * f1)
    (hg2 : g2 = u^3 * f2)
    (hg1p : g1p = 3*u^2*up*f1 + u^3*f1p)
    (hg2p : g2p = 3*u^2*up*f2 + u^3*f2p) :
    wronskianValue g1 g2 g1p g2p
      = u^6 * wronskianValue f1 f2 f1p f2p := by
  rw [hg1, hg2, hg1p, hg2p]
  simp only [wronskianValue]
  ring

/-- Polynomial form of the hyperbola condition: from
`u * W(f1,f2) = -Delta`, clearing cubic poles gives
`W(g1,g2) = -Delta*u^5`. -/
theorem cleared_hyperbola_wronskian
    (u up f1 f2 f1p f2p g1 g2 g1p g2p Delta : K)
    (hg1 : g1 = u^3 * f1)
    (hg2 : g2 = u^3 * f2)
    (hg1p : g1p = 3*u^2*up*f1 + u^3*f1p)
    (hg2p : g2p = 3*u^2*up*f2 + u^3*f2p)
    (hscaled : u * wronskianValue f1 f2 f1p f2p = -Delta) :
    wronskianValue g1 g2 g1p g2p = -Delta * u^5 := by
  rw [cubic_denominator_wronskian u up f1 f2 f1p f2p g1 g2 g1p g2p
    hg1 hg2 hg1p hg2p]
  calc
    u^6 * wronskianValue f1 f2 f1p f2p
        = u^5 * (u * wronskianValue f1 f2 f1p f2p) := by ring
    _ = u^5 * (-Delta) := by rw [hscaled]
    _ = -Delta * u^5 := by ring

#print axioms source_linear_covariance
#print axioms target_linear_covariance
#print axioms parametrized_contracted_curve_identity
#print axioms contracted_curve_is_smooth
#print axioms cubic_denominator_wronskian
#print axioms cleared_hyperbola_wronskian

end MixedGammaIdentities
