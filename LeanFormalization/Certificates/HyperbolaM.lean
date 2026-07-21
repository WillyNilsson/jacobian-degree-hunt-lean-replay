import Mathlib

/-!
Automatically generated exact Nullstellensatz replay for `h_m`.
Canonical system SHA-256: `a266649de502a2116815fa29d80ed8997f16f0027c70dc9ab1264548c9b2b66c`.
Source Singular dump SHA-256: `71f76f2c25eded26edf63947ef4df2a7224570e65ccd2606c0c24645f0375a3a`.
Global denominator cleared: `30`.

The generator independently verified the rational identity before emitting
this file. The mathematical trust boundary is still Lean's `ring` proof.
-/

namespace MixedGammaCertificates
namespace HyperbolaM

variable {K : Type*} [Field K] [CharZero K]

set_option maxHeartbeats 8000000
set_option maxRecDepth 200000

def e1 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  a11 + 2*b02 + 2

def e2 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -2*a02*b11 - a02*m + 2*a11*b02 + 2*a11 + a12 + 3*b02 + 3*b03

def e3 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -3*a02*b11 - 2*a02*b12 - a02 - 3*a03*b11 - 2*a03*m + 3*a11*b02 + 3*a11*b03 + 2*a12*b02 + 2*a12 + 4*b03

def e4 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  a02*b03*m - 3*a02*b12 - a03*b02*m - 4*a03*b11 - 3*a03*b12 - 2*a03 + 4*a11*b03 + 3*a12*b02 + 3*a12*b03

def e5 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  a02*b03 - a03*b02 - 4*a03*b12 + 4*a12*b03

def e6 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  2*a20 + b11 + 2*m

def e7 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -4*a02*b20 + a11*m + 4*a20*b02 + 4*a20 + 2*a21 + 4*b02*m + b11 + 2*b12 + 3

def e8 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -3*a02*b11*m - 6*a02*b20 - 4*a02*b21 - 6*a03*b20 + 3*a11*b02*m + a11*b12 + 2*a11 - a12*b11 + 6*a20*b02 + 6*a20*b03 + 4*a21*b02 + 4*a21 + 5*b02 + 6*b03*m + 2*b12

def e9 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -4*a02*b11 - 2*a02*b12*m - 6*a02*b21 - 5*a03*b11*m - 8*a03*b20 - 6*a03*b21 + 4*a11*b02 + 5*a11*b03*m + a11*b12 + 2*a12*b02*m - a12*b11 + a12 + 8*a20*b03 + 6*a21*b02 + 6*a21*b03 + 7*b03

def e10 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -3*a02*b12 - 6*a03*b11 - 4*a03*b12*m - 8*a03*b21 + 6*a11*b03 + 3*a12*b02 + 4*a12*b03*m + 8*a21*b03

def e11 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -5*a03*b12 + 5*a12*b03

def e12 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -2*a11*b20 + 2*a20*b11 + 3*a20*m + 3*a30 + 2*b11*m - b20 + b21

def e13 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -6*a02*b20*m - 6*a02*b30 - 3*a11*b20 - a11*b21 - 4*a12*b20 + 6*a20*b02*m + 3*a20*b11 + 4*a20*b12 + 5*a20 + a21*b11 + 2*a21*m + 6*a30*b02 + 6*a30 + 2*b11 + 4*b12*m

def e14 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -8*a02*b20 - 5*a02*b21*m - 9*a02*b30 - 9*a03*b20*m - 9*a03*b30 + 2*a11*b12*m - 2*a11*b21 - 2*a12*b11*m - 5*a12*b20 - 3*a12*b21 + 8*a20*b02 + 9*a20*b03*m + 5*a20*b12 + 5*a21*b02*m + 2*a21*b11 + 3*a21*b12 + 4*a21 + 9*a30*b02 + 9*a30*b03 + 4*b12

def e15 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -7*a02*b21 - 11*a03*b20 - 8*a03*b21*m - 12*a03*b30 + 2*a11*b12 - 2*a12*b11 - 4*a12*b21 + 11*a20*b03 + 7*a21*b02 + 8*a21*b03*m + 4*a21*b12 + 12*a30*b03

def e16 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -10*a03*b21 + 10*a21*b03

def e17 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -3*a11*b20*m - 3*a11*b30 + 3*a20*b11*m + 2*a20*b21 - 2*a21*b20 + 3*a30*b11 + 4*a30*m - b20 + 2*b21*m - 2*b30

def e18 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -8*a02*b30*m - 4*a11*b20 - a11*b21*m - 5*a11*b30 - 6*a12*b20*m - 6*a12*b30 + 4*a20*b11 + 6*a20*b12*m + 2*a20*b21 + a21*b11*m - 2*a21*b20 + 8*a30*b02*m + 5*a30*b11 + 6*a30*b12 + 7*a30 + b21

def e19 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -11*a02*b30 - 12*a03*b30*m - 2*a11*b21 - 7*a12*b20 - 4*a12*b21*m - 8*a12*b30 + 7*a20*b12 + 2*a21*b11 + 4*a21*b12*m + 11*a30*b02 + 12*a30*b03*m + 8*a30*b12

def e20 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -15*a03*b30 - 5*a12*b21 + 5*a21*b12 + 15*a30*b03

def e21 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -4*a11*b30*m + 3*a20*b21*m - a20*b30 - 3*a21*b20*m - 3*a21*b30 + 4*a30*b11*m + a30*b20 + 3*a30*b21 - 2*b30

def e22 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -6*a11*b30 - 8*a12*b30*m + 3*a20*b21 - 3*a21*b20 - 4*a21*b30 + 6*a30*b11 + 8*a30*b12*m + 4*a30*b21

def e23 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -10*a12*b30 + 10*a30*b12

def e24 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -a20*b30 - 4*a21*b30*m + a30*b20 + 4*a30*b21*m

def e25 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -5*a21*b30 + 5*a30*b21

def e26 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -a02*b03*m + a02*b03 - a02*b11 + a02*b12 + a02*m - a02 + a03*b02*m - a03*b02 + a03*b11 - a03*b12 - 2*a03*m + 2*a03 + a11*b02 - a11*b03 - a11 - a12*b02 + a12*b03 + a12 - b02 + b03 + 2

def e27 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -4*a02*b03*m^2 + 4*a02*b03*m - 2*a02*b11*m - 4*a02*b11 + 4*a02*b12*m + 2*a02*b12 + 2*a02*b20 - 2*a02*b21 + 2*a02*m^2 - 2*a02 + 4*a03*b02*m^2 - 4*a03*b02*m + 2*a03*b11*m + 4*a03*b11 - 4*a03*b12*m - 2*a03*b12 - 2*a03*b20 + 2*a03*b21 - 6*a03*m^2 + 4*a03*m + 2*a03 + 2*a11*b02*m + 4*a11*b02 - 2*a11*b03*m - 4*a11*b03 - 2*a11*m - 4*a11 - 4*a12*b02*m - 2*a12*b02 + 4*a12*b03*m + 2*a12*b03 + 4*a12*m + 2*a12 - 2*a20*b02 + 2*a20*b03 + 2*a20 + 2*a21*b02 - 2*a21*b03 - 2*a21 - 6*b02 + 6*b03 + 11

def e28 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -6*a02*b03*m^3 + 6*a02*b03*m^2 - a02*b11*m^2 - 9*a02*b11*m - 5*a02*b11 + 6*a02*b12*m^2 + 8*a02*b12*m + a02*b12 + 2*a02*b20*m + 10*a02*b20 - 5*a02*b21*m - 7*a02*b21 + 3*a02*b30 + a02*m^3 + 3*a02*m^2 - 3*a02*m - a02 + 6*a03*b02*m^3 - 6*a03*b02*m^2 + 12*a03*b11*m + 3*a03*b11 - 6*a03*b12*m^2 - 9*a03*b12*m - 3*a03*b20*m - 9*a03*b20 + 6*a03*b21*m + 6*a03*b21 - 3*a03*b30 - 6*a03*m^3 + 6*a03*m + a11*b02*m^2 + 9*a11*b02*m + 5*a11*b02 - 12*a11*b03*m - 3*a11*b03 - a11*b12*m + a11*b12 - a11*b20 + a11*b21 - a11*m^2 - 8*a11*m - 6*a11 - 6*a12*b02*m^2 - 8*a12*b02*m - a12*b02 + 6*a12*b03*m^2 + 9*a12*b03*m + a12*b11*m - a12*b11 + a12*b20 - a12*b21 + 5*a12*m^2 + 9*a12*m + a12 - 2*a20*b02*m - 10*a20*b02 + 3*a20*b03*m + 9*a20*b03 + a20*b11 - a20*b12 + a20*m + 11*a20 + 5*a21*b02*m + 7*a21*b02 - 6*a21*b03*m - 6*a21*b03 - a21*b11 + a21*b12 - 4*a21*m - 8*a21 - 3*a30*b02 + 3*a30*b03 + 3*a30 + b02*m^2 - 4*b02*m - 12*b02 - 3*b03*m^2 + 9*b03*m + 9*b03 - b11*m + b11 + 2*b12*m - 2*b12 + b20 - b21 + m + 24

def e29 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -4*a02*b03*m^4 + 4*a02*b03*m^3 - 6*a02*b11*m^2 - 12*a02*b11*m - 2*a02*b11 + 4*a02*b12*m^3 + 12*a02*b12*m^2 + 4*a02*b12*m + 12*a02*b20*m + 18*a02*b20 - 4*a02*b21*m^2 - 18*a02*b21*m - 8*a02*b21 + 4*a02*b30*m + 14*a02*b30 + 2*a02*m^3 - 2*a02*m + 4*a03*b02*m^4 - 4*a03*b02*m^3 - 2*a03*b11*m^3 + 12*a03*b11*m^2 + 10*a03*b11*m - 4*a03*b12*m^3 - 16*a03*b12*m^2 - 18*a03*b20*m - 12*a03*b20 + 6*a03*b21*m^2 + 20*a03*b21*m + 4*a03*b21 - 6*a03*b30*m - 12*a03*b30 - 2*a03*m^4 - 4*a03*m^3 + 6*a03*m^2 + 6*a11*b02*m^2 + 12*a11*b02*m + 2*a11*b02 + 2*a11*b03*m^3 - 12*a11*b03*m^2 - 10*a11*b03*m - 2*a11*b12*m^2 + 2*a11*b12 - 6*a11*b20 + 2*a11*b21*m + 4*a11*b21 - 2*a11*b30 - 4*a11*m^2 - 12*a11*m - 4*a11 - 4*a12*b02*m^3 - 12*a12*b02*m^2 - 4*a12*b02*m + 4*a12*b03*m^3 + 16*a12*b03*m^2 + 2*a12*b11*m^2 - 2*a12*b11 + 6*a12*b20 - 2*a12*b21*m - 4*a12*b21 + 2*a12*b30 + 2*a12*m^3 + 12*a12*m^2 + 6*a12*m - 12*a20*b02*m - 18*a20*b02 + 18*a20*b03*m + 12*a20*b03 + 6*a20*b11 - 6*a20*b12 + 6*a20*m + 24*a20 + 4*a21*b02*m^2 + 18*a21*b02*m + 8*a21*b02 - 6*a21*b03*m^2 - 20*a21*b03*m - 4*a21*b03 - 2*a21*b11*m - 4*a21*b11 + 2*a21*b12*m + 4*a21*b12 - 2*a21*m^2 - 16*a21*m - 12*a21 - 4*a30*b02*m - 14*a30*b02 + 6*a30*b03*m + 12*a30*b03 + 2*a30*b11 - 2*a30*b12 + 2*a30*m + 16*a30 + 2*b02*m^2 - 12*b02*m - 10*b02 - 2*b03*m^3 + 18*b03*m + 4*b03 - 4*b11*m + 4*b11 + 2*b12*m^2 + 4*b12*m - 6*b12 + 6*b20 - 2*b21*m - 4*b21 + 2*b30 + 4*m + 26

def e30 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -a02*b03*m^5 + a02*b03*m^4 - a02*b11*m^3 - 9*a02*b11*m^2 - 5*a02*b11*m + a02*b12*m^4 + 8*a02*b12*m^3 + 6*a02*b12*m^2 + 2*a02*b20*m^2 + 24*a02*b20*m + 14*a02*b20 - a02*b21*m^3 - 15*a02*b21*m^2 - 21*a02*b21*m - 3*a02*b21 + a02*b30*m^2 + 20*a02*b30*m + 24*a02*b30 + a02*m^3 - a02*m^2 + a03*b02*m^5 - a03*b02*m^4 - a03*b11*m^4 + 4*a03*b11*m^3 + 12*a03*b11*m^2 - a03*b12*m^4 - 14*a03*b12*m^3 + a03*b20*m^3 - 9*a03*b20*m^2 - 27*a03*b20*m - 5*a03*b20 + 2*a03*b21*m^3 + 24*a03*b21*m^2 + 14*a03*b21*m - 3*a03*b30*m^2 - 27*a03*b30*m - 15*a03*b30 - 2*a03*m^4 + 2*a03*m^3 + a11*b02*m^3 + 9*a11*b02*m^2 + 5*a11*b02*m + a11*b03*m^4 - 4*a11*b03*m^3 - 12*a11*b03*m^2 - a11*b12*m^3 - 3*a11*b12*m^2 + 3*a11*b12*m + a11*b12 - a11*b20*m - 14*a11*b20 + a11*b21*m^2 + 8*a11*b21*m + 6*a11*b21 - a11*b30*m - 11*a11*b30 - 6*a11*m^2 - 8*a11*m - a11 - a12*b02*m^4 - 8*a12*b02*m^3 - 6*a12*b02*m^2 + a12*b03*m^4 + 14*a12*b03*m^3 + a12*b11*m^3 + 3*a12*b11*m^2 - 3*a12*b11*m - a12*b11 - a12*b20*m^2 + 4*a12*b20*m + 12*a12*b20 - a12*b21*m^2 - 9*a12*b21*m - 5*a12*b21 + 2*a12*b30*m + 10*a12*b30 + 5*a12*m^3 + 9*a12*m^2 + a12*m - 2*a20*b02*m^2 - 24*a20*b02*m - 14*a20*b02 - a20*b03*m^3 + 9*a20*b03*m^2 + 27*a20*b03*m + 5*a20*b03 + a20*b11*m + 14*a20*b11 + a20*b12*m^2 - 4*a20*b12*m - 12*a20*b12 - a20*b21*m + a20*b21 + a20*b30 + 14*a20*m + 26*a20 + a21*b02*m^3 + 15*a21*b02*m^2 + 21*a21*b02*m + 3*a21*b02 - 2*a21*b03*m^3 - 24*a21*b03*m^2 - 14*a21*b03*m - a21*b11*m^2 - 8*a21*b11*m - 6*a21*b11 + a21*b12*m^2 + 9*a21*b12*m + 5*a21*b12 + a21*b20*m - a21*b20 - a21*b30 - 8*a21*m^2 - 24*a21*m - 8*a21 - a30*b02*m^2 - 20*a30*b02*m - 24*a30*b02 + 3*a30*b03*m^2 + 27*a30*b03*m + 15*a30*b03 + a30*b11*m + 11*a30*b11 - 2*a30*b12*m - 10*a30*b12 - a30*b20 + a30*b21 + 11*a30*m + 34*a30 - 12*b02*m - 3*b02 - 3*b03*m^3 + 9*b03*m^2 + 9*b03*m - 6*b11*m + 6*b11 + 6*b12*m^2 - 6*b12 + 15*b20 - 9*b21*m - 6*b21 + 12*b30 + 6*m + 14

def e31 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -2*a02*b11*m^3 - 4*a02*b11*m^2 + 2*a02*b12*m^4 + 4*a02*b12*m^3 + 6*a02*b20*m^2 + 20*a02*b20*m + 4*a02*b20 - 4*a02*b21*m^3 - 18*a02*b21*m^2 - 8*a02*b21*m + 6*a02*b30*m^2 + 36*a02*b30*m + 18*a02*b30 + 6*a03*b11*m^3 - 6*a03*b12*m^4 - 18*a03*b20*m^2 - 12*a03*b20*m + 12*a03*b21*m^3 + 18*a03*b21*m^2 - 18*a03*b30*m^2 - 36*a03*b30*m - 6*a03*b30 + 2*a11*b02*m^3 + 4*a11*b02*m^2 - 6*a11*b03*m^3 - 2*a11*b12*m^3 + 2*a11*b12*m - 4*a11*b20*m - 16*a11*b20 + 4*a11*b21*m^2 + 12*a11*b21*m + 4*a11*b21 - 6*a11*b30*m - 24*a11*b30 - 4*a11*m^2 - 2*a11*m - 2*a12*b02*m^4 - 4*a12*b02*m^3 + 6*a12*b03*m^4 + 2*a12*b11*m^3 - 2*a12*b11*m - 2*a12*b20*m^2 + 12*a12*b20*m + 10*a12*b20 - 6*a12*b21*m^2 - 12*a12*b21*m - 2*a12*b21 + 12*a12*b30*m + 18*a12*b30 + 4*a12*m^3 + 2*a12*m^2 - 6*a20*b02*m^2 - 20*a20*b02*m - 4*a20*b02 + 18*a20*b03*m^2 + 12*a20*b03*m + 4*a20*b11*m + 16*a20*b11 + 2*a20*b12*m^2 - 12*a20*b12*m - 10*a20*b12 - 4*a20*b21*m + 4*a20*b21 + 6*a20*b30 + 16*a20*m + 14*a20 + 4*a21*b02*m^3 + 18*a21*b02*m^2 + 8*a21*b02*m - 12*a21*b03*m^3 - 18*a21*b03*m^2 - 4*a21*b11*m^2 - 12*a21*b11*m - 4*a21*b11 + 6*a21*b12*m^2 + 12*a21*b12*m + 2*a21*b12 + 4*a21*b20*m - 4*a21*b20 - 6*a21*b30 - 12*a21*m^2 - 16*a21*m - 2*a21 - 6*a30*b02*m^2 - 36*a30*b02*m - 18*a30*b02 + 18*a30*b03*m^2 + 36*a30*b03*m + 6*a30*b03 + 6*a30*b11*m + 24*a30*b11 - 12*a30*b12*m - 18*a30*b12 - 6*a30*b20 + 6*a30*b21 + 24*a30*m + 36*a30 - 2*b02*m^2 - 4*b02*m + 6*b03*m^2 - 4*b11*m + 4*b11 + 6*b12*m^2 - 4*b12*m - 2*b12 + 20*b20 - 16*b21*m - 4*b21 + 30*b30 + 4*m + 3

def e32 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -a02*b11*m^3 + a02*b12*m^4 + 6*a02*b20*m^2 + 6*a02*b20*m - 5*a02*b21*m^3 - 7*a02*b21*m^2 + 12*a02*b30*m^2 + 28*a02*b30*m + 5*a02*b30 + a03*b11*m^4 - a03*b12*m^5 - 3*a03*b20*m^3 - 9*a03*b20*m^2 + 2*a03*b21*m^4 + 10*a03*b21*m^3 - 3*a03*b30*m^3 - 27*a03*b30*m^2 - 15*a03*b30*m + a11*b02*m^3 - a11*b03*m^4 - a11*b12*m^3 + a11*b12*m^2 - 6*a11*b20*m - 9*a11*b20 + 6*a11*b21*m^2 + 8*a11*b21*m + a11*b21 - 14*a11*b30*m - 26*a11*b30 - a11*m^2 - a12*b02*m^4 + a12*b03*m^5 + a12*b11*m^3 - a12*b11*m^2 + 12*a12*b20*m + 3*a12*b20 - a12*b21*m^3 - 9*a12*b21*m^2 - 5*a12*b21*m + 2*a12*b30*m^2 + 24*a12*b30*m + 14*a12*b30 + a12*m^3 - 6*a20*b02*m^2 - 6*a20*b02*m + 3*a20*b03*m^3 + 9*a20*b03*m^2 + 6*a20*b11*m + 9*a20*b11 - 12*a20*b12*m - 3*a20*b12 - 6*a20*b21*m + 6*a20*b21 + 15*a20*b30 + 9*a20*m + 3*a20 + 5*a21*b02*m^3 + 7*a21*b02*m^2 - 2*a21*b03*m^4 - 10*a21*b03*m^3 - 6*a21*b11*m^2 - 8*a21*b11*m - a21*b11 + a21*b12*m^3 + 9*a21*b12*m^2 + 5*a21*b12*m + 6*a21*b20*m - 6*a21*b20 - a21*b30*m - 14*a21*b30 - 8*a21*m^2 - 4*a21*m - 12*a30*b02*m^2 - 28*a30*b02*m - 5*a30*b02 + 3*a30*b03*m^3 + 27*a30*b03*m^2 + 15*a30*b03*m + 14*a30*b11*m + 26*a30*b11 - 2*a30*b12*m^2 - 24*a30*b12*m - 14*a30*b12 - 15*a30*b20 + a30*b21*m + 14*a30*b21 + 26*a30*m + 19*a30 - b02*m^2 + b03*m^3 - b11*m + b11 + 2*b12*m^2 - 2*b12*m + 15*b20 - 14*b21*m - b21 + 40*b30 + m

def e33 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  2*a02*b20*m^2 - 2*a02*b21*m^3 + 10*a02*b30*m^2 + 8*a02*b30*m - 2*a03*b20*m^3 + 2*a03*b21*m^4 - 6*a03*b30*m^3 - 12*a03*b30*m^2 - 4*a11*b20*m - 2*a11*b20 + 4*a11*b21*m^2 + 2*a11*b21*m - 16*a11*b30*m - 14*a11*b30 + 2*a12*b20*m^2 + 4*a12*b20*m - 2*a12*b21*m^3 - 4*a12*b21*m^2 + 6*a12*b30*m^2 + 20*a12*b30*m + 4*a12*b30 - 2*a20*b02*m^2 + 2*a20*b03*m^3 + 4*a20*b11*m + 2*a20*b11 - 2*a20*b12*m^2 - 4*a20*b12*m - 4*a20*b21*m + 4*a20*b21 + 20*a20*b30 + 2*a20*m + 2*a21*b02*m^3 - 2*a21*b03*m^4 - 4*a21*b11*m^2 - 2*a21*b11*m + 2*a21*b12*m^3 + 4*a21*b12*m^2 + 4*a21*b20*m - 4*a21*b20 - 4*a21*b30*m - 16*a21*b30 - 2*a21*m^2 - 10*a30*b02*m^2 - 8*a30*b02*m + 6*a30*b03*m^3 + 12*a30*b03*m^2 + 16*a30*b11*m + 14*a30*b11 - 6*a30*b12*m^2 - 20*a30*b12*m - 4*a30*b12 - 20*a30*b20 + 4*a30*b21*m + 16*a30*b21 + 14*a30*m + 4*a30 + 6*b20 - 6*b21*m + 30*b30

def e34 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  3*a02*b30*m^2 - 3*a03*b30*m^3 - a11*b20*m + a11*b21*m^2 - 9*a11*b30*m - 3*a11*b30 + a12*b20*m^2 - a12*b21*m^3 + 6*a12*b30*m^2 + 6*a12*b30*m + a20*b11*m - a20*b12*m^2 - a20*b21*m + a20*b21 + 15*a20*b30 - a21*b11*m^2 + a21*b12*m^3 + a21*b20*m - a21*b20 - 6*a21*b30*m - 9*a21*b30 - 3*a30*b02*m^2 + 3*a30*b03*m^3 + 9*a30*b11*m + 3*a30*b11 - 6*a30*b12*m^2 - 6*a30*b12*m - 15*a30*b20 + 6*a30*b21*m + 9*a30*b21 + 3*a30*m + b20 - b21*m + 12*b30

def e35 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -2*a11*b30*m + 2*a12*b30*m^2 + 6*a20*b30 - 4*a21*b30*m - 2*a21*b30 + 2*a30*b11*m - 2*a30*b12*m^2 - 6*a30*b20 + 4*a30*b21*m + 2*a30*b21 + 2*b30

def e36 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  a20*b30 - a21*b30*m - a30*b20 + a30*b21*m

def w1 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -30*m^4 + 30*m

def w2 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  30*m^4 - 30*m^2

def w3 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -30*m^4 + 30*m^3

def w5 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  30*m^5 - 30*m^4

def w6 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  30

def w7 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -40*m + 10

def w8 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  50*m^2 - 20*m

def w9 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -60*m^3 + 30*m^2

def w10 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  70*m^4 - 40*m^3

def w11 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -80*m^5 + 50*m^4

def w12 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -30

def w13 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  50*m - 20

def w14 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -75*m^2 + 50*m - 5

def w15 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  105*m^3 - 90*m^2 + 15*m

def w16 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -140*m^4 + 140*m^3 - 30*m^2

def w17 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  30

def w18 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -60*m + 30

def w19 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  105*m^2 - 90*m + 15

def w20 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -168*m^3 + 189*m^2 - 54*m + 3

def w21 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -30

def w22 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  70*m - 40

def w23 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -140*m^2 + 140*m - 30

def w25 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -50*m + 50

def w26 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  30*m^4

def w36 (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) : K :=
  -30

/-- Integer-cleared form of the explicit Singular lift certificate. -/
theorem certificate_identity (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K) :
    w1 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e1 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w2 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e2 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w3 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e3 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w5 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e5 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w6 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e6 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w7 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e7 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w8 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e8 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w9 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e9 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w10 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e10 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w11 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e11 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w12 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e12 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w13 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e13 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w14 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e14 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w15 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e15 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w16 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e16 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w17 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e17 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w18 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e18 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w19 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e19 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w20 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e20 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w21 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e21 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w22 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e22 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w23 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e23 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w25 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e25 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w26 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e26 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      + w36 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m * e36 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
      = (30 : K) := by
  unfold e1 e2 e3 e5 e6 e7 e8 e9 e10 e11 e12 e13 e14 e15 e16 e17 e18 e19 e20 e21 e22 e23 e25 e26 e36 w1 w2 w3 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 w20 w21 w22 w23 w25 w26 w36
  ring

/-- The displayed case system has no solution over a characteristic-zero field. -/
theorem no_solution (a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m : K)
    (h1 : e1 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h2 : e2 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h3 : e3 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h4 : e4 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h5 : e5 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h6 : e6 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h7 : e7 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h8 : e8 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h9 : e9 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h10 : e10 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h11 : e11 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h12 : e12 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h13 : e13 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h14 : e14 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h15 : e15 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h16 : e16 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h17 : e17 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h18 : e18 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h19 : e19 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h20 : e20 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h21 : e21 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h22 : e22 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h23 : e23 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h24 : e24 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h25 : e25 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h26 : e26 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h27 : e27 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h28 : e28 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h29 : e29 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h30 : e30 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h31 : e31 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h32 : e32 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h33 : e33 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h34 : e34 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h35 : e35 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    (h36 : e36 a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m = 0)
    : False := by
  have hcert := certificate_identity a02 a03 a11 a12 a20 a21 a30 b02 b03 b11 b12 b20 b21 b30 m
  rw [h1, h2, h3, h5, h6, h7, h8, h9, h10, h11, h12, h13, h14, h15, h16, h17, h18, h19, h20, h21, h22, h23, h25, h26, h36] at hcert
  norm_num at hcert

#print axioms certificate_identity
#print axioms no_solution

end HyperbolaM
end MixedGammaCertificates
