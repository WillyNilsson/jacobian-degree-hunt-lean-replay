import Mathlib
import Mathlib.Algebra.MvPolynomial.PDeriv

/-!
# Full cubic determinant bridge

Generated review candidate for the complete normalized cubic ansatz,
including the previously omitted `a03*t^3` and `b03*t^3` terms.
It defines the literal bivariate determinant and all 27 nonconstant
coefficients of `Delta - 1`, then states/proves the same coefficient
bridge pattern used successfully in `RawDeltaBridge.lean`.

This file was generated and algebraically cross-checked with SymPy, but
has not been compiled in the present environment. Keep it outside the
default Lake target until GitHub CI has confirmed it.
-/

namespace FullCubicScaffold

open MvPolynomial

variable {K : Type*} [Field K] [CharZero K]

set_option maxHeartbeats 8000000
set_option maxRecDepth 200000

noncomputable section

structure Coefficients (K : Type*) where
  a20 : K
  a11 : K
  a02 : K
  a30 : K
  a21 : K
  a12 : K
  a03 : K
  b20 : K
  b11 : K
  b02 : K
  b30 : K
  b21 : K
  b12 : K
  b03 : K
  c10 : K
  c01 : K
  c20 : K
  c11 : K
  c02 : K

abbrev Bivar (K : Type*) [CommSemiring K] := MvPolynomial (Fin 2) K

def v : Bivar K := X 0
def t : Bivar K := X 1

def alpha (x : Coefficients K) : Bivar K :=
  v + C x.a20*v^2 + C x.a11*v*t + C x.a02*t^2
    + C x.a30*v^3 + C x.a21*v^2*t + C x.a12*v*t^2 + C x.a03*t^3

def beta (x : Coefficients K) : Bivar K :=
  t + C x.b20*v^2 + C x.b11*v*t + C x.b02*t^2
    + C x.b30*v^3 + C x.b21*v^2*t + C x.b12*v*t^2 + C x.b03*t^3

def gamma (x : Coefficients K) : Bivar K :=
  1 + C x.c10*v + C x.c01*t + C x.c20*v^2 + C x.c11*v*t + C x.c02*t^2

def bracket (p q : Bivar K) : Bivar K :=
  pderiv 0 p * pderiv 1 q - pderiv 1 p * pderiv 0 q

def delta (x : Coefficients K) : Bivar K :=
  gamma x * bracket (alpha x) (beta x)
    + beta x * bracket (alpha x) (gamma x)
    + alpha x * bracket (gamma x) (beta x)

def e01 (x : Coefficients K) : K :=
  x.a11 + 2*x.b02 + 2*x.c01
def e10 (x : Coefficients K) : K :=
  2*x.a20 + x.b11 + 2*x.c10
def e02 (x : Coefficients K) : K :=
  -2*x.a02*x.b11 - x.a02*x.c10 + 2*x.a11*x.b02 + 2*x.a11*x.c01 + x.a12 + 3*x.b02*x.c01 + 3*x.b03 + 3*x.c02
def e11 (x : Coefficients K) : K :=
  -4*x.a02*x.b20 + x.a11*x.c10 + 4*x.a20*x.b02 + 4*x.a20*x.c01 + 2*x.a21 + 4*x.b02*x.c10 + x.b11*x.c01 + 2*x.b12 + 3*x.c11
def e20 (x : Coefficients K) : K :=
  -2*x.a11*x.b20 + 2*x.a20*x.b11 + 3*x.a20*x.c10 + 3*x.a30 + 2*x.b11*x.c10 - x.b20*x.c01 + x.b21 + 3*x.c20
def e03 (x : Coefficients K) : K :=
  -3*x.a02*x.b11*x.c01 - 2*x.a02*x.b12 - x.a02*x.c11 - 3*x.a03*x.b11 - 2*x.a03*x.c10 + 3*x.a11*x.b02*x.c01 + 3*x.a11*x.b03 + 3*x.a11*x.c02 + 2*x.a12*x.b02 + 2*x.a12*x.c01 + 4*x.b02*x.c02 + 4*x.b03*x.c01
def e12 (x : Coefficients K) : K :=
  -3*x.a02*x.b11*x.c10 - 6*x.a02*x.b20*x.c01 - 4*x.a02*x.b21 - 2*x.a02*x.c20 - 6*x.a03*x.b20 + 3*x.a11*x.b02*x.c10 + x.a11*x.b12 + 2*x.a11*x.c11 - x.a12*x.b11 + 6*x.a20*x.b02*x.c01 + 6*x.a20*x.b03 + 6*x.a20*x.c02 + 4*x.a21*x.b02 + 4*x.a21*x.c01 + 5*x.b02*x.c11 + 6*x.b03*x.c10 + x.b11*x.c02 + 2*x.b12*x.c01
def e21 (x : Coefficients K) : K :=
  -6*x.a02*x.b20*x.c10 - 6*x.a02*x.b30 - 3*x.a11*x.b20*x.c01 - x.a11*x.b21 + x.a11*x.c20 - 4*x.a12*x.b20 + 6*x.a20*x.b02*x.c10 + 3*x.a20*x.b11*x.c01 + 4*x.a20*x.b12 + 5*x.a20*x.c11 + x.a21*x.b11 + 2*x.a21*x.c10 + 6*x.a30*x.b02 + 6*x.a30*x.c01 + 6*x.b02*x.c20 + 2*x.b11*x.c11 + 4*x.b12*x.c10 - 2*x.b20*x.c02
def e30 (x : Coefficients K) : K :=
  -3*x.a11*x.b20*x.c10 - 3*x.a11*x.b30 + 3*x.a20*x.b11*x.c10 + 2*x.a20*x.b21 + 4*x.a20*x.c20 - 2*x.a21*x.b20 + 3*x.a30*x.b11 + 4*x.a30*x.c10 + 3*x.b11*x.c20 - x.b20*x.c11 + 2*x.b21*x.c10 - 2*x.b30*x.c01
def e04 (x : Coefficients K) : K :=
  x.a02*x.b03*x.c10 - 4*x.a02*x.b11*x.c02 - 3*x.a02*x.b12*x.c01 - x.a03*x.b02*x.c10 - 4*x.a03*x.b11*x.c01 - 3*x.a03*x.b12 - 2*x.a03*x.c11 + 4*x.a11*x.b02*x.c02 + 4*x.a11*x.b03*x.c01 + 3*x.a12*x.b02*x.c01 + 3*x.a12*x.b03 + 3*x.a12*x.c02 + 5*x.b03*x.c02
def e13 (x : Coefficients K) : K :=
  -4*x.a02*x.b11*x.c11 - 2*x.a02*x.b12*x.c10 - 8*x.a02*x.b20*x.c02 - 6*x.a02*x.b21*x.c01 - 5*x.a03*x.b11*x.c10 - 8*x.a03*x.b20*x.c01 - 6*x.a03*x.b21 - 4*x.a03*x.c20 + 4*x.a11*x.b02*x.c11 + 5*x.a11*x.b03*x.c10 + x.a11*x.b12*x.c01 + 2*x.a12*x.b02*x.c10 - x.a12*x.b11*x.c01 + x.a12*x.c11 + 8*x.a20*x.b02*x.c02 + 8*x.a20*x.b03*x.c01 + 6*x.a21*x.b02*x.c01 + 6*x.a21*x.b03 + 6*x.a21*x.c02 + 7*x.b03*x.c11 + 2*x.b12*x.c02
def e22 (x : Coefficients K) : K :=
  -4*x.a02*x.b11*x.c20 - 8*x.a02*x.b20*x.c11 - 5*x.a02*x.b21*x.c10 - 9*x.a02*x.b30*x.c01 - 9*x.a03*x.b20*x.c10 - 9*x.a03*x.b30 + 4*x.a11*x.b02*x.c20 + 2*x.a11*x.b12*x.c10 - 4*x.a11*x.b20*x.c02 - 2*x.a11*x.b21*x.c01 - 2*x.a12*x.b11*x.c10 - 5*x.a12*x.b20*x.c01 - 3*x.a12*x.b21 - x.a12*x.c20 + 8*x.a20*x.b02*x.c11 + 9*x.a20*x.b03*x.c10 + 4*x.a20*x.b11*x.c02 + 5*x.a20*x.b12*x.c01 + 5*x.a21*x.b02*x.c10 + 2*x.a21*x.b11*x.c01 + 3*x.a21*x.b12 + 4*x.a21*x.c11 + 9*x.a30*x.b02*x.c01 + 9*x.a30*x.b03 + 9*x.a30*x.c02 + 9*x.b03*x.c20 + 4*x.b12*x.c11 - x.b21*x.c02
def e31 (x : Coefficients K) : K :=
  -8*x.a02*x.b20*x.c20 - 8*x.a02*x.b30*x.c10 - 4*x.a11*x.b20*x.c11 - x.a11*x.b21*x.c10 - 5*x.a11*x.b30*x.c01 - 6*x.a12*x.b20*x.c10 - 6*x.a12*x.b30 + 8*x.a20*x.b02*x.c20 + 4*x.a20*x.b11*x.c11 + 6*x.a20*x.b12*x.c10 + 2*x.a20*x.b21*x.c01 + x.a21*x.b11*x.c10 - 2*x.a21*x.b20*x.c01 + 2*x.a21*x.c20 + 8*x.a30*x.b02*x.c10 + 5*x.a30*x.b11*x.c01 + 6*x.a30*x.b12 + 7*x.a30*x.c11 + 6*x.b12*x.c20 + x.b21*x.c11 - 4*x.b30*x.c02
def e40 (x : Coefficients K) : K :=
  -4*x.a11*x.b20*x.c20 - 4*x.a11*x.b30*x.c10 + 4*x.a20*x.b11*x.c20 + 3*x.a20*x.b21*x.c10 - x.a20*x.b30*x.c01 - 3*x.a21*x.b20*x.c10 - 3*x.a21*x.b30 + 4*x.a30*x.b11*x.c10 + x.a30*x.b20*x.c01 + 3*x.a30*x.b21 + 5*x.a30*x.c20 + 3*x.b21*x.c20 - 2*x.b30*x.c11
def e05 (x : Coefficients K) : K :=
  x.a02*x.b03*x.c11 - 4*x.a02*x.b12*x.c02 - x.a03*x.b02*x.c11 - 5*x.a03*x.b11*x.c02 - 4*x.a03*x.b12*x.c01 + 5*x.a11*x.b03*x.c02 + 4*x.a12*x.b02*x.c02 + 4*x.a12*x.b03*x.c01
def e14 (x : Coefficients K) : K :=
  2*x.a02*x.b03*x.c20 - 3*x.a02*x.b12*x.c11 - 8*x.a02*x.b21*x.c02 - 2*x.a03*x.b02*x.c20 - 6*x.a03*x.b11*x.c11 - 4*x.a03*x.b12*x.c10 - 10*x.a03*x.b20*x.c02 - 8*x.a03*x.b21*x.c01 + 6*x.a11*x.b03*x.c11 + x.a11*x.b12*x.c02 + 3*x.a12*x.b02*x.c11 + 4*x.a12*x.b03*x.c10 - x.a12*x.b11*x.c02 + 10*x.a20*x.b03*x.c02 + 8*x.a21*x.b02*x.c02 + 8*x.a21*x.b03*x.c01
def e23 (x : Coefficients K) : K :=
  -2*x.a02*x.b12*x.c20 - 7*x.a02*x.b21*x.c11 - 12*x.a02*x.b30*x.c02 - 7*x.a03*x.b11*x.c20 - 11*x.a03*x.b20*x.c11 - 8*x.a03*x.b21*x.c10 - 12*x.a03*x.b30*x.c01 + 7*x.a11*x.b03*x.c20 + 2*x.a11*x.b12*x.c11 - 3*x.a11*x.b21*x.c02 + 2*x.a12*x.b02*x.c20 - 2*x.a12*x.b11*x.c11 - 6*x.a12*x.b20*x.c02 - 4*x.a12*x.b21*x.c01 + 11*x.a20*x.b03*x.c11 + 6*x.a20*x.b12*x.c02 + 7*x.a21*x.b02*x.c11 + 8*x.a21*x.b03*x.c10 + 3*x.a21*x.b11*x.c02 + 4*x.a21*x.b12*x.c01 + 12*x.a30*x.b02*x.c02 + 12*x.a30*x.b03*x.c01
def e32 (x : Coefficients K) : K :=
  -6*x.a02*x.b21*x.c20 - 11*x.a02*x.b30*x.c11 - 12*x.a03*x.b20*x.c20 - 12*x.a03*x.b30*x.c10 + 3*x.a11*x.b12*x.c20 - 2*x.a11*x.b21*x.c11 - 7*x.a11*x.b30*x.c02 - 3*x.a12*x.b11*x.c20 - 7*x.a12*x.b20*x.c11 - 4*x.a12*x.b21*x.c10 - 8*x.a12*x.b30*x.c01 + 12*x.a20*x.b03*x.c20 + 7*x.a20*x.b12*x.c11 + 2*x.a20*x.b21*x.c02 + 6*x.a21*x.b02*x.c20 + 2*x.a21*x.b11*x.c11 + 4*x.a21*x.b12*x.c10 - 2*x.a21*x.b20*x.c02 + 11*x.a30*x.b02*x.c11 + 12*x.a30*x.b03*x.c10 + 7*x.a30*x.b11*x.c02 + 8*x.a30*x.b12*x.c01
def e41 (x : Coefficients K) : K :=
  -10*x.a02*x.b30*x.c20 - x.a11*x.b21*x.c20 - 6*x.a11*x.b30*x.c11 - 8*x.a12*x.b20*x.c20 - 8*x.a12*x.b30*x.c10 + 8*x.a20*x.b12*x.c20 + 3*x.a20*x.b21*x.c11 - 2*x.a20*x.b30*x.c02 + x.a21*x.b11*x.c20 - 3*x.a21*x.b20*x.c11 - 4*x.a21*x.b30*x.c01 + 10*x.a30*x.b02*x.c20 + 6*x.a30*x.b11*x.c11 + 8*x.a30*x.b12*x.c10 + 2*x.a30*x.b20*x.c02 + 4*x.a30*x.b21*x.c01
def e50 (x : Coefficients K) : K :=
  -5*x.a11*x.b30*x.c20 + 4*x.a20*x.b21*x.c20 - x.a20*x.b30*x.c11 - 4*x.a21*x.b20*x.c20 - 4*x.a21*x.b30*x.c10 + 5*x.a30*x.b11*x.c20 + x.a30*x.b20*x.c11 + 4*x.a30*x.b21*x.c10
def e06 (x : Coefficients K) : K :=
  -5*x.a03*x.b12*x.c02 + 5*x.a12*x.b03*x.c02
def e15 (x : Coefficients K) : K :=
  -5*x.a03*x.b12*x.c11 - 10*x.a03*x.b21*x.c02 + 5*x.a12*x.b03*x.c11 + 10*x.a21*x.b03*x.c02
def e24 (x : Coefficients K) : K :=
  -5*x.a03*x.b12*x.c20 - 10*x.a03*x.b21*x.c11 - 15*x.a03*x.b30*x.c02 + 5*x.a12*x.b03*x.c20 - 5*x.a12*x.b21*x.c02 + 10*x.a21*x.b03*x.c11 + 5*x.a21*x.b12*x.c02 + 15*x.a30*x.b03*x.c02
def e33 (x : Coefficients K) : K :=
  -10*x.a03*x.b21*x.c20 - 15*x.a03*x.b30*x.c11 - 5*x.a12*x.b21*x.c11 - 10*x.a12*x.b30*x.c02 + 10*x.a21*x.b03*x.c20 + 5*x.a21*x.b12*x.c11 + 15*x.a30*x.b03*x.c11 + 10*x.a30*x.b12*x.c02
def e42 (x : Coefficients K) : K :=
  -15*x.a03*x.b30*x.c20 - 5*x.a12*x.b21*x.c20 - 10*x.a12*x.b30*x.c11 + 5*x.a21*x.b12*x.c20 - 5*x.a21*x.b30*x.c02 + 15*x.a30*x.b03*x.c20 + 10*x.a30*x.b12*x.c11 + 5*x.a30*x.b21*x.c02
def e51 (x : Coefficients K) : K :=
  -10*x.a12*x.b30*x.c20 - 5*x.a21*x.b30*x.c11 + 10*x.a30*x.b12*x.c20 + 5*x.a30*x.b21*x.c11
def e60 (x : Coefficients K) : K :=
  -5*x.a21*x.b30*x.c20 + 5*x.a30*x.b21*x.c20

structure RawSystem (x : Coefficients K) : Prop where
  e01 : e01 x = 0
  e10 : e10 x = 0
  e02 : e02 x = 0
  e11 : e11 x = 0
  e20 : e20 x = 0
  e03 : e03 x = 0
  e12 : e12 x = 0
  e21 : e21 x = 0
  e30 : e30 x = 0
  e04 : e04 x = 0
  e13 : e13 x = 0
  e22 : e22 x = 0
  e31 : e31 x = 0
  e40 : e40 x = 0
  e05 : e05 x = 0
  e14 : e14 x = 0
  e23 : e23 x = 0
  e32 : e32 x = 0
  e41 : e41 x = 0
  e50 : e50 x = 0
  e06 : e06 x = 0
  e15 : e15 x = 0
  e24 : e24 x = 0
  e33 : e33 x = 0
  e42 : e42 x = 0
  e51 : e51 x = 0
  e60 : e60 x = 0

def term (i j : Nat) (a : K) : Bivar K := C a * v^i * t^j

def rawPolynomial (x : Coefficients K) : Bivar K :=
  term 0 1 (e01 x)
    + term 1 0 (e10 x)
    + term 0 2 (e02 x)
    + term 1 1 (e11 x)
    + term 2 0 (e20 x)
    + term 0 3 (e03 x)
    + term 1 2 (e12 x)
    + term 2 1 (e21 x)
    + term 3 0 (e30 x)
    + term 0 4 (e04 x)
    + term 1 3 (e13 x)
    + term 2 2 (e22 x)
    + term 3 1 (e31 x)
    + term 4 0 (e40 x)
    + term 0 5 (e05 x)
    + term 1 4 (e14 x)
    + term 2 3 (e23 x)
    + term 3 2 (e32 x)
    + term 4 1 (e41 x)
    + term 5 0 (e50 x)
    + term 0 6 (e06 x)
    + term 1 5 (e15 x)
    + term 2 4 (e24 x)
    + term 3 3 (e33 x)
    + term 4 2 (e42 x)
    + term 5 1 (e51 x)
    + term 6 0 (e60 x)

def exponent (i j : Nat) : Fin 2 →₀ Nat :=
  Finsupp.single 0 i + Finsupp.single 1 j

@[simp] lemma exponent_eq_exponent (i j k l : Nat) :
    exponent i j = exponent k l ↔ i = k ∧ j = l := by
  constructor
  · intro h
    constructor
    · simpa [exponent] using congrArg (fun z => z (0 : Fin 2)) h
    · simpa [exponent] using congrArg (fun z => z (1 : Fin 2)) h
  · rintro ⟨rfl, rfl⟩
    rfl

lemma term_eq_monomial (i j : Nat) (a : K) :
    term i j a = monomial (exponent i j) a := by
  rw [term, v, t, C_mul_X_pow_eq_monomial, ← monomial_add_single]
  rfl

private lemma pderiv_v_alpha (x : Coefficients K) :
    pderiv 0 (alpha x) =
      1 + 2*C x.a20*v + C x.a11*t + 3*C x.a30*v^2
        + 2*C x.a21*v*t + C x.a12*t^2 := by
  simp [alpha, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]
  ring

private lemma pderiv_t_alpha (x : Coefficients K) :
    pderiv 1 (alpha x) =
      C x.a11*v + 2*C x.a02*t + C x.a21*v^2
        + 2*C x.a12*v*t + 3*C x.a03*t^2 := by
  simp [alpha, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]
  ring

private lemma pderiv_v_beta (x : Coefficients K) :
    pderiv 0 (beta x) =
      2*C x.b20*v + C x.b11*t + 3*C x.b30*v^2
        + 2*C x.b21*v*t + C x.b12*t^2 := by
  simp [beta, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]
  ring

private lemma pderiv_t_beta (x : Coefficients K) :
    pderiv 1 (beta x) =
      1 + C x.b11*v + 2*C x.b02*t + C x.b21*v^2
        + 2*C x.b12*v*t + 3*C x.b03*t^2 := by
  simp [beta, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]
  ring

private lemma pderiv_v_gamma (x : Coefficients K) :
    pderiv 0 (gamma x) = C x.c10 + 2*C x.c20*v + C x.c11*t := by
  simp [gamma, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]
  ring

private lemma pderiv_t_gamma (x : Coefficients K) :
    pderiv 1 (gamma x) = C x.c01 + C x.c11*v + 2*C x.c02*t := by
  simp [gamma, v, t, MvPolynomial.pderiv_mul, MvPolynomial.pderiv_pow]
  ring

theorem delta_sub_one_expansion (x : Coefficients K) :
    delta x - 1 = rawPolynomial x := by
  unfold delta bracket
  rw [pderiv_v_alpha, pderiv_t_alpha, pderiv_v_beta, pderiv_t_beta,
    pderiv_v_gamma, pderiv_t_gamma]
  unfold alpha beta gamma rawPolynomial term v t
  unfold e01 e10 e02 e11 e20 e03 e12 e21 e30 e04 e13 e22 e31 e40 e05 e14 e23 e32 e41 e50 e06 e15 e24 e33 e42 e51 e60
  simp only [map_add, map_sub, map_mul, map_neg, map_ofNat]
  ring

private lemma raw_eq_zero_of_system (x : Coefficients K) (h : RawSystem x) :
    rawPolynomial x = 0 := by
  have h_e01 : e01 x = 0 := h.e01
  have h_e10 : e10 x = 0 := h.e10
  have h_e02 : e02 x = 0 := h.e02
  have h_e11 : e11 x = 0 := h.e11
  have h_e20 : e20 x = 0 := h.e20
  have h_e03 : e03 x = 0 := h.e03
  have h_e12 : e12 x = 0 := h.e12
  have h_e21 : e21 x = 0 := h.e21
  have h_e30 : e30 x = 0 := h.e30
  have h_e04 : e04 x = 0 := h.e04
  have h_e13 : e13 x = 0 := h.e13
  have h_e22 : e22 x = 0 := h.e22
  have h_e31 : e31 x = 0 := h.e31
  have h_e40 : e40 x = 0 := h.e40
  have h_e05 : e05 x = 0 := h.e05
  have h_e14 : e14 x = 0 := h.e14
  have h_e23 : e23 x = 0 := h.e23
  have h_e32 : e32 x = 0 := h.e32
  have h_e41 : e41 x = 0 := h.e41
  have h_e50 : e50 x = 0 := h.e50
  have h_e06 : e06 x = 0 := h.e06
  have h_e15 : e15 x = 0 := h.e15
  have h_e24 : e24 x = 0 := h.e24
  have h_e33 : e33 x = 0 := h.e33
  have h_e42 : e42 x = 0 := h.e42
  have h_e51 : e51 x = 0 := h.e51
  have h_e60 : e60 x = 0 := h.e60
  simp [rawPolynomial, h_e01, h_e10, h_e02, h_e11, h_e20, h_e03, h_e12, h_e21, h_e30, h_e04, h_e13, h_e22, h_e31, h_e40, h_e05, h_e14, h_e23, h_e32, h_e41, h_e50, h_e06, h_e15, h_e24, h_e33, h_e42, h_e51, h_e60, term]

private lemma raw_coefficient (x : Coefficients K) (i j : Nat) :
    coeff (exponent i j) (rawPolynomial x) =
      (if i = 0 ∧ j = 1 then e01 x else 0)
      + (if i = 1 ∧ j = 0 then e10 x else 0)
      + (if i = 0 ∧ j = 2 then e02 x else 0)
      + (if i = 1 ∧ j = 1 then e11 x else 0)
      + (if i = 2 ∧ j = 0 then e20 x else 0)
      + (if i = 0 ∧ j = 3 then e03 x else 0)
      + (if i = 1 ∧ j = 2 then e12 x else 0)
      + (if i = 2 ∧ j = 1 then e21 x else 0)
      + (if i = 3 ∧ j = 0 then e30 x else 0)
      + (if i = 0 ∧ j = 4 then e04 x else 0)
      + (if i = 1 ∧ j = 3 then e13 x else 0)
      + (if i = 2 ∧ j = 2 then e22 x else 0)
      + (if i = 3 ∧ j = 1 then e31 x else 0)
      + (if i = 4 ∧ j = 0 then e40 x else 0)
      + (if i = 0 ∧ j = 5 then e05 x else 0)
      + (if i = 1 ∧ j = 4 then e14 x else 0)
      + (if i = 2 ∧ j = 3 then e23 x else 0)
      + (if i = 3 ∧ j = 2 then e32 x else 0)
      + (if i = 4 ∧ j = 1 then e41 x else 0)
      + (if i = 5 ∧ j = 0 then e50 x else 0)
      + (if i = 0 ∧ j = 6 then e06 x else 0)
      + (if i = 1 ∧ j = 5 then e15 x else 0)
      + (if i = 2 ∧ j = 4 then e24 x else 0)
      + (if i = 3 ∧ j = 3 then e33 x else 0)
      + (if i = 4 ∧ j = 2 then e42 x else 0)
      + (if i = 5 ∧ j = 1 then e51 x else 0)
      + (if i = 6 ∧ j = 0 then e60 x else 0)
    := by
  classical
  simp [rawPolynomial, term_eq_monomial, coeff_monomial, eq_comm]

private lemma equation_zero_of_raw_zero
    (x : Coefficients K) (hraw : rawPolynomial x = 0)
    (i j : Nat) : coeff (exponent i j) (rawPolynomial x) = 0 := by
  rw [hraw]
  simp

theorem rawSystem_iff_delta_eq_one (x : Coefficients K) :
    RawSystem x ↔ delta x = 1 := by
  constructor
  · intro h
    apply sub_eq_zero.mp
    rw [delta_sub_one_expansion, raw_eq_zero_of_system x h]
  · intro hdelta
    have hraw : rawPolynomial x = 0 := by
      rw [← delta_sub_one_expansion, hdelta]
      ring
    have h_e01 : e01 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e10 : e10 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e02 : e02 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 2; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e11 : e11 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e20 : e20 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 2 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e03 : e03 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 3; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e12 : e12 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 2; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e21 : e21 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 2 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e30 : e30 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 3 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e04 : e04 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 4; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e13 : e13 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 3; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e22 : e22 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 2 2; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e31 : e31 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 3 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e40 : e40 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 4 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e05 : e05 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 5; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e14 : e14 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 4; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e23 : e23 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 2 3; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e32 : e32 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 3 2; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e41 : e41 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 4 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e50 : e50 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 5 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e06 : e06 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 6; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e15 : e15 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 5; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e24 : e24 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 2 4; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e33 : e33 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 3 3; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e42 : e42 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 4 2; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e51 : e51 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 5 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h_e60 : e60 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 6 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    exact {
      e01 := h_e01,
      e10 := h_e10,
      e02 := h_e02,
      e11 := h_e11,
      e20 := h_e20,
      e03 := h_e03,
      e12 := h_e12,
      e21 := h_e21,
      e30 := h_e30,
      e04 := h_e04,
      e13 := h_e13,
      e22 := h_e22,
      e31 := h_e31,
      e40 := h_e40,
      e05 := h_e05,
      e14 := h_e14,
      e23 := h_e23,
      e32 := h_e32,
      e41 := h_e41,
      e50 := h_e50,
      e06 := h_e06,
      e15 := h_e15,
      e24 := h_e24,
      e33 := h_e33,
      e42 := h_e42,
      e51 := h_e51,
      e60 := h_e60
    }

#print axioms delta_sub_one_expansion
#print axioms rawSystem_iff_delta_eq_one

end
end FullCubicScaffold
