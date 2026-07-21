import Mathlib

/-!
Automatically generated exact Nullstellensatz replay for `h_v`.
Canonical system SHA-256: `7d5058bbce36099a1cc87a7ca4d22262d68abaff63878326423ed8d7abab9d2f`.
Source Singular dump SHA-256: `73544ea827ab533fc8311e0b1d9cff6c51d9a25a177817598a28ed928bc6bbd9`.
Global denominator cleared: `30`.

The generator independently verified the rational identity before emitting
this file. The mathematical trust boundary is still Lean's `ring` proof.
-/

namespace MixedGammaCertificates
namespace HyperbolaV

variable {K : Type*} [Field K] [CharZero K]

set_option maxHeartbeats 8000000
set_option maxRecDepth 200000

def e1 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a11 + 2*b02

def e2 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a02*b11 - a02 + 2*a11*b02 + a12 + 3*b03

def e3 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a02*b12 - a02 - 3*a03*b11 - 2*a03 + 3*a11*b03 + 2*a12*b02

def e4 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a02*b03 - a03*b02 - 3*a03*b12 - 2*a03 + 3*a12*b03

def e5 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a02*b03 - a03*b02

def e6 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  2*a20 + b11 + 2

def e7 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -4*a02*b20 + a11 + 4*a20*b02 + 2*a21 + 4*b02 + 2*b12 + 3

def e8 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -3*a02*b11 - 4*a02*b21 - 6*a03*b20 + 3*a11*b02 + a11*b12 + 2*a11 - a12*b11 + 6*a20*b03 + 4*a21*b02 + 5*b02 + 6*b03

def e9 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -4*a02*b11 - 2*a02*b12 - 5*a03*b11 - 6*a03*b21 + 4*a11*b02 + 5*a11*b03 + 2*a12*b02 + a12 + 6*a21*b03 + 7*b03

def e10 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -3*a02*b12 - 6*a03*b11 - 4*a03*b12 + 6*a11*b03 + 3*a12*b02 + 4*a12*b03

def e11 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -5*a03*b12 + 5*a12*b03

def e12 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a11*b20 + 2*a20*b11 + 3*a20 + 3*a30 + 2*b11 + b21

def e13 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -6*a02*b20 - 6*a02*b30 - a11*b21 - 4*a12*b20 + 6*a20*b02 + 4*a20*b12 + 5*a20 + a21*b11 + 2*a21 + 6*a30*b02 + 2*b11 + 4*b12

def e14 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -8*a02*b20 - 5*a02*b21 - 9*a03*b20 - 9*a03*b30 + 2*a11*b12 - 2*a12*b11 - 3*a12*b21 + 8*a20*b02 + 9*a20*b03 + 5*a21*b02 + 3*a21*b12 + 4*a21 + 9*a30*b03 + 4*b12

def e15 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -7*a02*b21 - 11*a03*b20 - 8*a03*b21 + 2*a11*b12 - 2*a12*b11 + 11*a20*b03 + 7*a21*b02 + 8*a21*b03

def e16 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -10*a03*b21 + 10*a21*b03

def e17 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -3*a11*b20 - 3*a11*b30 + 3*a20*b11 + 2*a20*b21 - 2*a21*b20 + 3*a30*b11 + 4*a30 - b20 + 2*b21

def e18 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -8*a02*b30 - 4*a11*b20 - a11*b21 - 6*a12*b20 - 6*a12*b30 + 4*a20*b11 + 6*a20*b12 + a21*b11 + 8*a30*b02 + 6*a30*b12 + 7*a30 + b21

def e19 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -11*a02*b30 - 12*a03*b30 - 2*a11*b21 - 7*a12*b20 - 4*a12*b21 + 7*a20*b12 + 2*a21*b11 + 4*a21*b12 + 11*a30*b02 + 12*a30*b03

def e20 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -15*a03*b30 - 5*a12*b21 + 5*a21*b12 + 15*a30*b03

def e21 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -4*a11*b30 + 3*a20*b21 - 3*a21*b20 - 3*a21*b30 + 4*a30*b11 + 3*a30*b21 - 2*b30

def e22 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -6*a11*b30 - 8*a12*b30 + 3*a20*b21 - 3*a21*b20 + 6*a30*b11 + 8*a30*b12

def e23 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -10*a12*b30 + 10*a30*b12

def e24 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -a20*b30 - 4*a21*b30 + a30*b20 + 4*a30*b21

def e25 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -5*a21*b30 + 5*a30*b21

def e26 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a02*b03 - a03*b02

def e27 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  4*a02*b03 - 4*a03*b02 - 2*a03*b12 + 2*a03 + 2*a12*b03

def e28 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  6*a02*b03 + a02*b12 - a02 - 6*a03*b02 + 3*a03*b11 - 9*a03*b12 + 6*a03 - 3*a11*b03 - a12*b02 + 9*a12*b03

def e29 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  4*a02*b03 - 2*a02*b11 + 4*a02*b12 - 2*a02 - 4*a03*b02 + 10*a03*b11 - 16*a03*b12 + 4*a03*b21 + 6*a03 + 2*a11*b02 - 10*a11*b03 - 4*a12*b02 + 16*a12*b03 - 4*a21*b03 + 4*b03

def e30 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a02*b03 - 5*a02*b11 + 6*a02*b12 - 3*a02*b21 - a02 - a03*b02 + 12*a03*b11 - 14*a03*b12 - 5*a03*b20 + 14*a03*b21 + 2*a03 + 5*a11*b02 - 12*a11*b03 + a11*b12 - a11 - 6*a12*b02 + 14*a12*b03 - a12*b11 + a12 + 5*a20*b03 + 3*a21*b02 - 14*a21*b03 - 3*b02 + 9*b03

def e31 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -4*a02*b11 + 4*a02*b12 + 4*a02*b20 - 8*a02*b21 + 6*a03*b11 - 6*a03*b12 - 12*a03*b20 + 18*a03*b21 - 6*a03*b30 + 4*a11*b02 - 6*a11*b03 + 2*a11*b12 - 2*a11 - 4*a12*b02 + 6*a12*b03 - 2*a12*b11 - 2*a12*b21 + 2*a12 - 4*a20*b02 + 12*a20*b03 + 8*a21*b02 - 18*a21*b03 + 2*a21*b12 - 2*a21 + 6*a30*b03 - 4*b02 + 6*b03 - 2*b12 + 3

def e32 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -a02*b11 + a02*b12 + 6*a02*b20 - 7*a02*b21 + 5*a02*b30 + a03*b11 - a03*b12 - 9*a03*b20 + 10*a03*b21 - 15*a03*b30 + a11*b02 - a11*b03 + a11*b12 + a11*b21 - a11 - a12*b02 + a12*b03 - a12*b11 + 3*a12*b20 - 5*a12*b21 + a12 - 6*a20*b02 + 9*a20*b03 - 3*a20*b12 + 3*a20 + 7*a21*b02 - 10*a21*b03 - a21*b11 + 5*a21*b12 - 4*a21 - 5*a30*b02 + 15*a30*b03 - b02 + b03 + b11 - 2*b12 + 1

def e33 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  2*a02*b20 - 2*a02*b21 + 8*a02*b30 - 2*a03*b20 + 2*a03*b21 - 12*a03*b30 - 2*a11*b20 + 2*a11*b21 + 4*a12*b20 - 4*a12*b21 + 4*a12*b30 - 2*a20*b02 + 2*a20*b03 + 2*a20*b11 - 4*a20*b12 + 2*a20 + 2*a21*b02 - 2*a21*b03 - 2*a21*b11 + 4*a21*b12 - 2*a21 - 8*a30*b02 + 12*a30*b03 - 4*a30*b12 + 4*a30

def e34 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  3*a02*b30 - 3*a03*b30 - a11*b20 + a11*b21 - 3*a11*b30 + a12*b20 - a12*b21 + 6*a12*b30 + a20*b11 - a20*b12 + a20*b21 - a21*b11 + a21*b12 - a21*b20 - 3*a30*b02 + 3*a30*b03 + 3*a30*b11 - 6*a30*b12 + 3*a30 + b20 - b21

def e35 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -2*a11*b30 + 2*a12*b30 - 2*a21*b30 + 2*a30*b11 - 2*a30*b12 + 2*a30*b21 + 2*b30

def e36 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  a20*b30 - a21*b30 - a30*b20 + a30*b21

def w6 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -40

def w7 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  20

def w9 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -20

def w10 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  40

def w11 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -60

def w12 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  40

def w14 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -15

def w15 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  5

def w16 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  30

def w17 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -40

def w20 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  13

def w22 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  40

def w23 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -40

def w31 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  30

def w32 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -40

def w33 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  40

def w34 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) : K :=
  -40

/-- Integer-cleared form of the explicit Singular lift certificate. -/
theorem certificate_identity (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 : K) :
    w6 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e6 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w7 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e7 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w9 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e9 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w10 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e10 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w11 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e11 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w12 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e12 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w14 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e14 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w15 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e15 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w16 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e16 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w17 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e17 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w20 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e20 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w22 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e22 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w23 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e23 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w31 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e31 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w32 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e32 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w33 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e33 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      + w34 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 * e34 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30
      = (30 : K) := by
  unfold e6 e7 e9 e10 e11 e12 e14 e15 e16 e17 e20 e22 e23 e31 e32 e33 e34 w6 w7 w9 w10 w11 w12 w14 w15 w16 w17 w20 w22 w23 w31 w32 w33 w34
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
  rw [h6, h7, h9, h10, h11, h12, h14, h15, h16, h17, h20, h22, h23, h31, h32, h33, h34] at hcert
  norm_num at hcert

#print axioms certificate_identity
#print axioms no_solution

end HyperbolaV
end MixedGammaCertificates
