import Mathlib

/-!
Automatically generated exact Nullstellensatz replay for `constant_gamma_e2`.
Canonical system SHA-256: `42d93cca5339156ec39112eb4eaa6075a4220251d7e8669f71af98005140df6b`.
Source Singular dump SHA-256: `e64ecc703e95b0a1fa1c9e880bdf48f7900fcc6a1fc2f2538e3f719ba5843155`.
Global denominator cleared: `10368`.

The generator independently verified the rational identity before emitting
this file. The mathematical trust boundary is still Lean's `ring` proof.
-/

namespace MixedGammaCertificates
namespace ConstantGammaE2

variable {K : Type*} [Field K] [CharZero K]

set_option maxHeartbeats 8000000
set_option maxRecDepth 200000

def e1 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -3*a21*b30 + 3*a30*b21

def e2 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -6*a12*b30 + 6*a30*b12

def e3 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -3*a11*b30 + 2*a20*b21 - 2*a21*b20 + 3*a30*b11

def e4 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -9*a03*b30 - 3*a12*b21 + 3*a21*b12 + 9*a30*b03

def e5 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  6*a03*b30 - a11*b21 - 4*a12*b20 + 4*a20*b12 + a21*b11 - 6*a30*b03 - 6*a30

def e6 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -2*a11*b20 + 2*a20*b11 + 3*a30 + b21

def e7 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -6*a03*b21 + 6*a21*b03

def e8 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -6*a03*b20 + 4*a03*b21 + a11*b12 - a12*b11 + 6*a20*b03 - 4*a21*b03 - 4*a21

def e9 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  4*a03*b20 - 4*a20*b03 - 4*a20 + 2*a21 + 2*b12

def e10 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  2*a20 + b11

def e11 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -3*a03*b12 + 3*a12*b03

def e12 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -3*a03*b11 + 2*a03*b12 + 3*a11*b03 - 2*a12*b03 - 2*a12

def e13 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  2*a03*b11 - 2*a11*b03 - 2*a11 + a12 + 3*b03

def e14 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  a11 - 2*b03 - 2

def w4 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -4*a03^2

def w5 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -6*a03^2

def w6 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -12*a03^2

def w7 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -12*a03*b03 + 24*a03

def w8 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -12*a03*b03 + 72*a03

def w9 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  3*a03^2*b11 - 6*a03*b03^2 - 24*a03*b03 + 144*a03

def w10 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  6*a03^2*b03*b11 + 18*a03^2*b11 + 12*a03^2*b12 - 12*a03*b03^3 - 24*a03*b03^2 + 24*a03*b03 + 288*a03

def w11 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  24*a03^2*b20 + 16*a03^2*b21 - 16*a03*a21*b03 - 4*a03*a21 + 12*a03*b03*b11 - 108*a03*b11 - 12*a03*b12 + 192*b03^2 + 672*b03 - 672

def w12 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  36*a03^2*b20 + 24*a03^2*b21 - 24*a03*a21*b03 + 18*a03*b03*b11 - 162*a03*b11 - 18*a03*b12 + 288*b03^2 + 936*b03 - 1296

def w13 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  48*a03^2*b20 + 36*a03^2*b21 - 36*a03*a21*b03 + 24*a03*b03*b11 - 252*a03*b11 - 36*a03*b12 + 432*b03^2 + 1296*b03 - 2592

def w14 (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) : K :=
  -12*a03^2*b03*b20 + 72*a03^2*b20 + 66*a03^2*b21 - 72*a03*a21*b03 - 6*a03*b03^2*b11 + 30*a03*b03*b11 - 6*a03*b03*b12 - 504*a03*b11 - 144*a03*b12 + 648*b03^2 + 1296*b03 - 5184

/-- Integer-cleared form of the explicit Singular lift certificate. -/
theorem certificate_identity (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K) :
    w4 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e4 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      + w5 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e5 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      + w6 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e6 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      + w7 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e7 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      + w8 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e8 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      + w9 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e9 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      + w10 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e10 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      + w11 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e11 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      + w12 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e12 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      + w13 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e13 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      + w14 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 * e14 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
      = (10368 : K) := by
  unfold e4 e5 e6 e7 e8 e9 e10 e11 e12 e13 e14 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14
  ring

/-- The displayed case system has no solution over a characteristic-zero field. -/
theorem no_solution (a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 : K)
    (h1 : e1 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h2 : e2 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h3 : e3 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h4 : e4 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h5 : e5 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h6 : e6 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h7 : e7 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h8 : e8 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h9 : e9 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h10 : e10 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h11 : e11 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h12 : e12 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h13 : e13 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    (h14 : e14 a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03 = 0)
    : False := by
  have hcert := certificate_identity a20 a11 a30 a21 a12 a03 b20 b11 b30 b21 b12 b03
  rw [h4, h5, h6, h7, h8, h9, h10, h11, h12, h13, h14] at hcert
  norm_num at hcert

#print axioms certificate_identity
#print axioms no_solution

end ConstantGammaE2
end MixedGammaCertificates
