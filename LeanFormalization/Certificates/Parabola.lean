import Mathlib

/-!
Automatically generated exact Nullstellensatz replay for `p`.
Canonical system SHA-256: `d24e14c9d0db37e5013050ade166a9db44114d52670fdf00f2783c3095f994d1`.
Source Singular dump SHA-256: `8ee0a98fd065c5de8c1f1bc0736ae0a867264abab3c01859716a9a178b8db895`.
Global denominator cleared: `480`.

The generator independently verified the rational identity before emitting
this file. The mathematical trust boundary is still Lean's `ring` proof.
-/

namespace MixedGammaCertificates
namespace Parabola

variable {K : Type*} [Field K] [CharZero K]

set_option maxHeartbeats 8000000
set_option maxRecDepth 200000

def e1 (a21 a30 b21 b30 : K) : K :=
  a30 + 2*b21 + 2

def e2 (a21 a30 b21 b30 : K) : K :=
  -2*a21*b30 + 2*a30*b21 + 2*a30 + 3*b21

def e3 (a21 a30 b21 b30 : K) : K :=
  -3*a21*b30 + 3*a30*b21

def e4 (a21 a30 b21 b30 : K) : K :=
  -2*a21 + b30

def e5 (a21 a30 b21 b30 : K) : K :=
  -6*a21 + b30

def e6 (a21 a30 b21 b30 : K) : K :=
  -4*a21

def e7 (a21 a30 b21 b30 : K) : K :=
  -2*a21*b30 + 2*a30*b21 + a30 + 2*b21 + 2

def e8 (a21 a30 b21 b30 : K) : K :=
  -8*a21*b30 + 8*a30*b21 + 4*a30 + 6*b21

def e9 (a21 a30 b21 b30 : K) : K :=
  -11*a21*b30 + 11*a30*b21

def e10 (a21 a30 b21 b30 : K) : K :=
  -6*a21 + b30

def e11 (a21 a30 b21 b30 : K) : K :=
  -8*a21

def e12 (a21 a30 b21 b30 : K) : K :=
  -6*a21*b30 + 6*a30*b21 + 2*a30 + 3*b21

def e13 (a21 a30 b21 b30 : K) : K :=
  -13*a21*b30 + 13*a30*b21

def e14 (a21 a30 b21 b30 : K) : K :=
  -4*a21

def e15 (a21 a30 b21 b30 : K) : K :=
  -5*a21*b30 + 5*a30*b21

def w1 (a21 a30 b21 b30 : K) : K :=
  -60*b21 + 240

def w12 (a21 a30 b21 b30 : K) : K :=
  40*b21 - 120

def w14 (a21 a30 b21 b30 : K) : K :=
  5*b30

def w15 (a21 a30 b21 b30 : K) : K :=
  -48*b21 + 140

/-- Integer-cleared form of the explicit Singular lift certificate. -/
theorem certificate_identity (a21 a30 b21 b30 : K) :
    w1 a21 a30 b21 b30 * e1 a21 a30 b21 b30
      + w12 a21 a30 b21 b30 * e12 a21 a30 b21 b30
      + w14 a21 a30 b21 b30 * e14 a21 a30 b21 b30
      + w15 a21 a30 b21 b30 * e15 a21 a30 b21 b30
      = (480 : K) := by
  unfold e1 e12 e14 e15 w1 w12 w14 w15
  ring

/-- The displayed case system has no solution over a characteristic-zero field. -/
theorem no_solution (a21 a30 b21 b30 : K)
    (h1 : e1 a21 a30 b21 b30 = 0)
    (h2 : e2 a21 a30 b21 b30 = 0)
    (h3 : e3 a21 a30 b21 b30 = 0)
    (h4 : e4 a21 a30 b21 b30 = 0)
    (h5 : e5 a21 a30 b21 b30 = 0)
    (h6 : e6 a21 a30 b21 b30 = 0)
    (h7 : e7 a21 a30 b21 b30 = 0)
    (h8 : e8 a21 a30 b21 b30 = 0)
    (h9 : e9 a21 a30 b21 b30 = 0)
    (h10 : e10 a21 a30 b21 b30 = 0)
    (h11 : e11 a21 a30 b21 b30 = 0)
    (h12 : e12 a21 a30 b21 b30 = 0)
    (h13 : e13 a21 a30 b21 b30 = 0)
    (h14 : e14 a21 a30 b21 b30 = 0)
    (h15 : e15 a21 a30 b21 b30 = 0)
    : False := by
  have hcert := certificate_identity a21 a30 b21 b30
  rw [h1, h12, h14, h15] at hcert
  norm_num at hcert

#print axioms certificate_identity
#print axioms no_solution

end Parabola
end MixedGammaCertificates
