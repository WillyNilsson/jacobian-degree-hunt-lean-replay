import Mathlib

/-!
Automatically generated exact Nullstellensatz replay for `h_0`.
Canonical system SHA-256: `d6da3bbd8a47232b077cf7e5297d5d3489aa5751da174f7e1974ad8de227507e`.
Source Singular dump SHA-256: `f10579d5fa84676f12647f1df67759dbca7bc0f947a19809646542e4d31390a4`.
Global denominator cleared: `30`.

The generator independently verified the rational identity before emitting
this file. The mathematical trust boundary is still Lean's `ring` proof.
-/

namespace MixedGammaCertificates
namespace Hyperbola0

variable {K : Type*} [Field K] [CharZero K]

set_option maxHeartbeats 8000000
set_option maxRecDepth 200000

def e1 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a11 + 2*b02

def e2 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a02*b11 + 2*a11*b02 + a12 + 3*b03

def e3 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a02*b12 - a02 - 3*a03*b11 + 3*a11*b03 + 2*a12*b02

def e4 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -3*a03*b12 - 2*a03 + 3*a12*b03

def e5 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a02*b03 - a03*b02

def e6 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  2*a20 + b11

def e7 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -4*a02*b20 + 4*a20*b02 + 2*a21 + 2*b12 + 3

def e8 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -4*a02*b21 - 6*a03*b20 + a11*b12 + 2*a11 - a12*b11 + 6*a20*b03 + 4*a21*b02 + 5*b02

def e9 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -4*a02*b11 - 6*a03*b21 + 4*a11*b02 + a12 + 6*a21*b03 + 7*b03

def e10 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -3*a02*b12 - 6*a03*b11 + 6*a11*b03 + 3*a12*b02

def e11 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -5*a03*b12 + 5*a12*b03

def e12 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a11*b20 + 2*a20*b11 + 3*a30 + b21

def e13 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -6*a02*b30 - a11*b21 - 4*a12*b20 + 4*a20*b12 + 5*a20 + a21*b11 + 6*a30*b02 + 2*b11

def e14 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -8*a02*b20 - 9*a03*b30 - 3*a12*b21 + 8*a20*b02 + 3*a21*b12 + 4*a21 + 9*a30*b03 + 4*b12

def e15 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -7*a02*b21 - 11*a03*b20 + 2*a11*b12 - 2*a12*b11 + 11*a20*b03 + 7*a21*b02

def e16 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -10*a03*b21 + 10*a21*b03

def e17 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -3*a11*b30 + 2*a20*b21 - 2*a21*b20 + 3*a30*b11 - b20

def e18 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -4*a11*b20 - 6*a12*b30 + 4*a20*b11 + 6*a30*b12 + 7*a30 + b21

def e19 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -11*a02*b30 - 2*a11*b21 - 7*a12*b20 + 7*a20*b12 + 2*a21*b11 + 11*a30*b02

def e20 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -15*a03*b30 - 5*a12*b21 + 5*a21*b12 + 15*a30*b03

def e21 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -3*a21*b30 + 3*a30*b21 - 2*b30

def e22 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -6*a11*b30 + 3*a20*b21 - 3*a21*b20 + 6*a30*b11

def e23 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -10*a12*b30 + 10*a30*b12

def e24 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -a20*b30 + a30*b20

def e25 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -5*a21*b30 + 5*a30*b21

def e26 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a02*b03 - a03*b02

def e27 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a03*b12 + 2*a03 + 2*a12*b03

def e28 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a02*b12 - a02 + 3*a03*b11 - 3*a11*b03 - a12*b02

def e29 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a02*b11 + 4*a03*b21 + 2*a11*b02 - 4*a21*b03 + 4*b03

def e30 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -3*a02*b21 - 5*a03*b20 + a11*b12 - a11 - a12*b11 + 5*a20*b03 + 3*a21*b02 - 3*b02

def e31 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  4*a02*b20 - 6*a03*b30 - 2*a12*b21 - 4*a20*b02 + 2*a21*b12 - 2*a21 + 6*a30*b03 - 2*b12 + 3

def e32 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  5*a02*b30 + a11*b21 + 3*a12*b20 - 3*a20*b12 + 3*a20 - a21*b11 - 5*a30*b02 + b11

def e33 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a11*b20 + 4*a12*b30 + 2*a20*b11 - 4*a30*b12 + 4*a30

def e34 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -3*a11*b30 + a20*b21 - a21*b20 + 3*a30*b11 + b20

def e35 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a21*b30 + 2*a30*b21 + 2*b30

def e36 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a20*b30 - a30*b20

def w14 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  5

def w20 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -7

def w31 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  10

/-- Integer-cleared form of the explicit Singular lift certificate. -/
theorem certificate_identity (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) :
    w14 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e14 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w20 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e20 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w31 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e31 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      = (30 : K) := by
  unfold e14 e20 e31 w14 w20 w31
  ring

/-- The displayed case system has no solution over a characteristic-zero field. -/
theorem no_solution (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K)
    (h1 : e1 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h2 : e2 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h3 : e3 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h4 : e4 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h5 : e5 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h6 : e6 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h7 : e7 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h8 : e8 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h9 : e9 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h10 : e10 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h11 : e11 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h12 : e12 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h13 : e13 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h14 : e14 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h15 : e15 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h16 : e16 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h17 : e17 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h18 : e18 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h19 : e19 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h20 : e20 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h21 : e21 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h22 : e22 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h23 : e23 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h24 : e24 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h25 : e25 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h26 : e26 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h27 : e27 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h28 : e28 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h29 : e29 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h30 : e30 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h31 : e31 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h32 : e32 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h33 : e33 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h34 : e34 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h35 : e35 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    (h36 : e36 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 = 0)
    : False := by
  have hcert := certificate_identity a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
  rw [h14, h20, h31] at hcert
  norm_num at hcert

#print axioms certificate_identity
#print axioms no_solution

end Hyperbola0
end MixedGammaCertificates
