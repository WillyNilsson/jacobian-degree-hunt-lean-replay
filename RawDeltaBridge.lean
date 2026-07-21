import WronskianDischarge
import Mathlib.Algebra.MvPolynomial.PDeriv

/-!
# Kernel-level identification of `RawSystem` with the original determinant

This file defines the normalized degree-five ansatz as genuine bivariate
polynomials, defines `Delta` using formal partial derivatives, and proves that
`Delta = 1` is equivalent to the 25 equations in `RawSystem`.  It then composes
that equivalence with the distinct-root Wronskian-discharge theorems.
-/

namespace RawDeltaBridge

open DiagonalReduction WronskianDischarge
open MvPolynomial

variable {K : Type*} [Field K] [CharZero K]

set_option maxHeartbeats 2000000
set_option maxRecDepth 100000

noncomputable section

abbrev Bivar (K : Type*) [CommSemiring K] := MvPolynomial (Fin 2) K

def v : Bivar K := X 0
def t : Bivar K := X 1

/-- The normalized `alpha`, with the `t^3` coefficient set to zero. -/
def alpha (x : Coefficients K) : Bivar K :=
  v + C x.a20*v^2 + C x.a11*v*t + C x.a02*t^2
    + C x.a30*v^3 + C x.a21*v^2*t + C x.a12*v*t^2

/-- The normalized `beta`, with the `t^3` coefficient set to zero. -/
def beta (x : Coefficients K) : Bivar K :=
  t + C x.b20*v^2 + C x.b11*v*t + C x.b02*t^2
    + C x.b30*v^3 + C x.b21*v^2*t + C x.b12*v*t^2

/-- The normalized quadratic factor `gamma`. -/
def gamma (x : Coefficients K) : Bivar K :=
  1 + C x.c10*v + C x.c01*t + C x.c20*v^2
    + C x.c11*v*t + C x.c02*t^2

/-- The Poisson bracket in the two displayed variables. -/
def bracket (p q : Bivar K) : Bivar K :=
  pderiv 0 p * pderiv 1 q - pderiv 1 p * pderiv 0 q

/-- The determinant expression used by the degree-five search. -/
def delta (x : Coefficients K) : Bivar K :=
  gamma x * bracket (alpha x) (beta x)
    + beta x * bracket (alpha x) (gamma x)
    + alpha x * bracket (gamma x) (beta x)

-- The literal coefficient expressions, named so that the expansion theorem
-- and the projection back to `RawSystem` share one checked definition.

def e01 (x : Coefficients K) : K :=
  x.a11 + 2*x.b02 + 2*x.c01
def e10 (x : Coefficients K) : K :=
  2*x.a20 + x.b11 + 2*x.c10
def e02 (x : Coefficients K) : K :=
  -2*x.a02*x.b11 - x.a02*x.c10 + 2*x.a11*x.b02
    + 2*x.a11*x.c01 + x.a12 + 3*x.b02*x.c01 + 3*x.c02
def e11 (x : Coefficients K) : K :=
  -4*x.a02*x.b20 + x.a11*x.c10 + 4*x.a20*x.b02
    + 4*x.a20*x.c01 + 2*x.a21 + 4*x.b02*x.c10
    + x.b11*x.c01 + 2*x.b12 + 3*x.c11
def e20 (x : Coefficients K) : K :=
  -2*x.a11*x.b20 + 2*x.a20*x.b11 + 3*x.a20*x.c10
    + 3*x.a30 + 2*x.b11*x.c10 - x.b20*x.c01 + x.b21 + 3*x.c20
def e03 (x : Coefficients K) : K :=
  -3*x.a02*x.b11*x.c01 - 2*x.a02*x.b12 - x.a02*x.c11
    + 3*x.a11*x.b02*x.c01 + 3*x.a11*x.c02 + 2*x.a12*x.b02
    + 2*x.a12*x.c01 + 4*x.b02*x.c02
def e12 (x : Coefficients K) : K :=
  -3*x.a02*x.b11*x.c10 - 6*x.a02*x.b20*x.c01 - 4*x.a02*x.b21
    - 2*x.a02*x.c20 + 3*x.a11*x.b02*x.c10 + x.a11*x.b12
    + 2*x.a11*x.c11 - x.a12*x.b11 + 6*x.a20*x.b02*x.c01
    + 6*x.a20*x.c02 + 4*x.a21*x.b02 + 4*x.a21*x.c01
    + 5*x.b02*x.c11 + x.b11*x.c02 + 2*x.b12*x.c01
def e21 (x : Coefficients K) : K :=
  -6*x.a02*x.b20*x.c10 - 6*x.a02*x.b30 - 3*x.a11*x.b20*x.c01
    - x.a11*x.b21 + x.a11*x.c20 - 4*x.a12*x.b20
    + 6*x.a20*x.b02*x.c10 + 3*x.a20*x.b11*x.c01 + 4*x.a20*x.b12
    + 5*x.a20*x.c11 + x.a21*x.b11 + 2*x.a21*x.c10
    + 6*x.a30*x.b02 + 6*x.a30*x.c01 + 6*x.b02*x.c20
    + 2*x.b11*x.c11 + 4*x.b12*x.c10 - 2*x.b20*x.c02
def e30 (x : Coefficients K) : K :=
  -3*x.a11*x.b20*x.c10 - 3*x.a11*x.b30 + 3*x.a20*x.b11*x.c10
    + 2*x.a20*x.b21 + 4*x.a20*x.c20 - 2*x.a21*x.b20
    + 3*x.a30*x.b11 + 4*x.a30*x.c10 + 3*x.b11*x.c20
    - x.b20*x.c11 + 2*x.b21*x.c10 - 2*x.b30*x.c01
def e04 (x : Coefficients K) : K :=
  -4*x.a02*x.b11*x.c02 - 3*x.a02*x.b12*x.c01
    + 4*x.a11*x.b02*x.c02 + 3*x.a12*x.b02*x.c01 + 3*x.a12*x.c02
def e13 (x : Coefficients K) : K :=
  -4*x.a02*x.b11*x.c11 - 2*x.a02*x.b12*x.c10
    - 8*x.a02*x.b20*x.c02 - 6*x.a02*x.b21*x.c01
    + 4*x.a11*x.b02*x.c11 + x.a11*x.b12*x.c01
    + 2*x.a12*x.b02*x.c10 - x.a12*x.b11*x.c01 + x.a12*x.c11
    + 8*x.a20*x.b02*x.c02 + 6*x.a21*x.b02*x.c01
    + 6*x.a21*x.c02 + 2*x.b12*x.c02
def e22 (x : Coefficients K) : K :=
  -4*x.a02*x.b11*x.c20 - 8*x.a02*x.b20*x.c11
    - 5*x.a02*x.b21*x.c10 - 9*x.a02*x.b30*x.c01
    + 4*x.a11*x.b02*x.c20 + 2*x.a11*x.b12*x.c10
    - 4*x.a11*x.b20*x.c02 - 2*x.a11*x.b21*x.c01
    - 2*x.a12*x.b11*x.c10 - 5*x.a12*x.b20*x.c01 - 3*x.a12*x.b21
    - x.a12*x.c20 + 8*x.a20*x.b02*x.c11 + 4*x.a20*x.b11*x.c02
    + 5*x.a20*x.b12*x.c01 + 5*x.a21*x.b02*x.c10
    + 2*x.a21*x.b11*x.c01 + 3*x.a21*x.b12 + 4*x.a21*x.c11
    + 9*x.a30*x.b02*x.c01 + 9*x.a30*x.c02
    + 4*x.b12*x.c11 - x.b21*x.c02
def e31 (x : Coefficients K) : K :=
  -8*x.a02*x.b20*x.c20 - 8*x.a02*x.b30*x.c10
    - 4*x.a11*x.b20*x.c11 - x.a11*x.b21*x.c10
    - 5*x.a11*x.b30*x.c01 - 6*x.a12*x.b20*x.c10 - 6*x.a12*x.b30
    + 8*x.a20*x.b02*x.c20 + 4*x.a20*x.b11*x.c11
    + 6*x.a20*x.b12*x.c10 + 2*x.a20*x.b21*x.c01
    + x.a21*x.b11*x.c10 - 2*x.a21*x.b20*x.c01 + 2*x.a21*x.c20
    + 8*x.a30*x.b02*x.c10 + 5*x.a30*x.b11*x.c01
    + 6*x.a30*x.b12 + 7*x.a30*x.c11 + 6*x.b12*x.c20
    + x.b21*x.c11 - 4*x.b30*x.c02
def e40 (x : Coefficients K) : K :=
  -4*x.a11*x.b20*x.c20 - 4*x.a11*x.b30*x.c10
    + 4*x.a20*x.b11*x.c20 + 3*x.a20*x.b21*x.c10
    - x.a20*x.b30*x.c01 - 3*x.a21*x.b20*x.c10 - 3*x.a21*x.b30
    + 4*x.a30*x.b11*x.c10 + x.a30*x.b20*x.c01
    + 3*x.a30*x.b21 + 5*x.a30*x.c20 + 3*x.b21*x.c20
    - 2*x.b30*x.c11
def e05 (x : Coefficients K) : K :=
  -4*x.a02*x.b12*x.c02 + 4*x.a12*x.b02*x.c02
def e14 (x : Coefficients K) : K :=
  -3*x.a02*x.b12*x.c11 - 8*x.a02*x.b21*x.c02
    + x.a11*x.b12*x.c02 + 3*x.a12*x.b02*x.c11
    - x.a12*x.b11*x.c02 + 8*x.a21*x.b02*x.c02
def e23 (x : Coefficients K) : K :=
  -2*x.a02*x.b12*x.c20 - 7*x.a02*x.b21*x.c11
    - 12*x.a02*x.b30*x.c02 + 2*x.a11*x.b12*x.c11
    - 3*x.a11*x.b21*x.c02 + 2*x.a12*x.b02*x.c20
    - 2*x.a12*x.b11*x.c11 - 6*x.a12*x.b20*x.c02
    - 4*x.a12*x.b21*x.c01 + 6*x.a20*x.b12*x.c02
    + 7*x.a21*x.b02*x.c11 + 3*x.a21*x.b11*x.c02
    + 4*x.a21*x.b12*x.c01 + 12*x.a30*x.b02*x.c02
def e32 (x : Coefficients K) : K :=
  -6*x.a02*x.b21*x.c20 - 11*x.a02*x.b30*x.c11
    + 3*x.a11*x.b12*x.c20 - 2*x.a11*x.b21*x.c11
    - 7*x.a11*x.b30*x.c02 - 3*x.a12*x.b11*x.c20
    - 7*x.a12*x.b20*x.c11 - 4*x.a12*x.b21*x.c10
    - 8*x.a12*x.b30*x.c01 + 7*x.a20*x.b12*x.c11
    + 2*x.a20*x.b21*x.c02 + 6*x.a21*x.b02*x.c20
    + 2*x.a21*x.b11*x.c11 + 4*x.a21*x.b12*x.c10
    - 2*x.a21*x.b20*x.c02 + 11*x.a30*x.b02*x.c11
    + 7*x.a30*x.b11*x.c02 + 8*x.a30*x.b12*x.c01
def e41 (x : Coefficients K) : K :=
  -10*x.a02*x.b30*x.c20 - x.a11*x.b21*x.c20
    - 6*x.a11*x.b30*x.c11 - 8*x.a12*x.b20*x.c20
    - 8*x.a12*x.b30*x.c10 + 8*x.a20*x.b12*x.c20
    + 3*x.a20*x.b21*x.c11 - 2*x.a20*x.b30*x.c02
    + x.a21*x.b11*x.c20 - 3*x.a21*x.b20*x.c11
    - 4*x.a21*x.b30*x.c01 + 10*x.a30*x.b02*x.c20
    + 6*x.a30*x.b11*x.c11 + 8*x.a30*x.b12*x.c10
    + 2*x.a30*x.b20*x.c02 + 4*x.a30*x.b21*x.c01
def e50 (x : Coefficients K) : K :=
  -5*x.a11*x.b30*x.c20 + 4*x.a20*x.b21*x.c20
    - x.a20*x.b30*x.c11 - 4*x.a21*x.b20*x.c20
    - 4*x.a21*x.b30*x.c10 + 5*x.a30*x.b11*x.c20
    + x.a30*x.b20*x.c11 + 4*x.a30*x.b21*x.c10
def e24 (x : Coefficients K) : K :=
  -5*x.a12*x.b21*x.c02 + 5*x.a21*x.b12*x.c02
def e33 (x : Coefficients K) : K :=
  -5*x.a12*x.b21*x.c11 - 10*x.a12*x.b30*x.c02
    + 5*x.a21*x.b12*x.c11 + 10*x.a30*x.b12*x.c02
def e42 (x : Coefficients K) : K :=
  -5*x.a12*x.b21*x.c20 - 10*x.a12*x.b30*x.c11
    + 5*x.a21*x.b12*x.c20 - 5*x.a21*x.b30*x.c02
    + 10*x.a30*x.b12*x.c11 + 5*x.a30*x.b21*x.c02
def e51 (x : Coefficients K) : K :=
  -10*x.a12*x.b30*x.c20 - 5*x.a21*x.b30*x.c11
    + 10*x.a30*x.b12*x.c20 + 5*x.a30*x.b21*x.c11
def e60 (x : Coefficients K) : K :=
  -5*x.a21*x.b30*x.c20 + 5*x.a30*x.b21*x.c20

/-- A coefficient times `v^i t^j`. -/
def term (i j : Nat) (a : K) : Bivar K := C a * v^i * t^j

/-- The sparse polynomial whose 25 displayed coefficients are `RawSystem`. -/
def rawPolynomial (x : Coefficients K) : Bivar K :=
  term 0 1 (e01 x) + term 1 0 (e10 x)
    + term 0 2 (e02 x) + term 1 1 (e11 x) + term 2 0 (e20 x)
    + term 0 3 (e03 x) + term 1 2 (e12 x) + term 2 1 (e21 x)
    + term 3 0 (e30 x) + term 0 4 (e04 x) + term 1 3 (e13 x)
    + term 2 2 (e22 x) + term 3 1 (e31 x) + term 4 0 (e40 x)
    + term 0 5 (e05 x) + term 1 4 (e14 x) + term 2 3 (e23 x)
    + term 3 2 (e32 x) + term 4 1 (e41 x) + term 5 0 (e50 x)
    + term 2 4 (e24 x) + term 3 3 (e33 x) + term 4 2 (e42 x)
    + term 5 1 (e51 x) + term 6 0 (e60 x)

/-- The exponent vector of `v^i t^j`. -/
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
        + 2*C x.a12*v*t := by
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
        + 2*C x.b12*v*t := by
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

/-- Direct symbolic expansion of the internally defined determinant. -/
theorem delta_sub_one_expansion (x : Coefficients K) :
    delta x - 1 = rawPolynomial x := by
  unfold delta bracket
  rw [pderiv_v_alpha, pderiv_t_alpha, pderiv_v_beta, pderiv_t_beta,
    pderiv_v_gamma, pderiv_t_gamma]
  unfold alpha beta gamma rawPolynomial term v t
  unfold e01 e10 e02 e11 e20 e03 e12 e21 e30 e04 e13 e22 e31 e40
  unfold e05 e14 e23 e32 e41 e50 e24 e33 e42 e51 e60
  simp only [map_add, map_sub, map_mul, map_neg, map_ofNat]
  ring

private lemma raw_eq_zero_of_system (x : Coefficients K) (h : RawSystem x) :
    rawPolynomial x = 0 := by
  have h01 : e01 x = 0 := by simpa [e01] using h.e01
  have h10 : e10 x = 0 := by simpa [e10] using h.e10
  have h02 : e02 x = 0 := by simpa [e02] using h.e02
  have h11 : e11 x = 0 := by simpa [e11] using h.e11
  have h20 : e20 x = 0 := by simpa [e20] using h.e20
  have h03 : e03 x = 0 := by simpa [e03] using h.e03
  have h12 : e12 x = 0 := by simpa [e12] using h.e12
  have h21 : e21 x = 0 := by simpa [e21] using h.e21
  have h30 : e30 x = 0 := by simpa [e30] using h.e30
  have h04 : e04 x = 0 := by simpa [e04] using h.e04
  have h13 : e13 x = 0 := by simpa [e13] using h.e13
  have h22 : e22 x = 0 := by simpa [e22] using h.e22
  have h31 : e31 x = 0 := by simpa [e31] using h.e31
  have h40 : e40 x = 0 := by simpa [e40] using h.e40
  have h05 : e05 x = 0 := by simpa [e05] using h.e05
  have h14 : e14 x = 0 := by simpa [e14] using h.e14
  have h23 : e23 x = 0 := by simpa [e23] using h.e23
  have h32 : e32 x = 0 := by simpa [e32] using h.e32
  have h41 : e41 x = 0 := by simpa [e41] using h.e41
  have h50 : e50 x = 0 := by simpa [e50] using h.e50
  have h24 : e24 x = 0 := by simpa [e24] using h.e24
  have h33 : e33 x = 0 := by simpa [e33] using h.e33
  have h42 : e42 x = 0 := by simpa [e42] using h.e42
  have h51 : e51 x = 0 := by simpa [e51] using h.e51
  have h60 : e60 x = 0 := by simpa [e60] using h.e60
  simp [rawPolynomial, h01, h10, h02, h11, h20, h03, h12, h21, h30,
    h04, h13, h22, h31, h40, h05, h14, h23, h32, h41, h50, h24,
    h33, h42, h51, h60, term]

private lemma raw_coefficient
    (x : Coefficients K) (i j : Nat) :
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
      + (if i = 2 ∧ j = 4 then e24 x else 0)
      + (if i = 3 ∧ j = 3 then e33 x else 0)
      + (if i = 4 ∧ j = 2 then e42 x else 0)
      + (if i = 5 ∧ j = 1 then e51 x else 0)
      + (if i = 6 ∧ j = 0 then e60 x else 0) := by
  classical
  simp [rawPolynomial, term_eq_monomial, coeff_monomial, eq_comm]

private lemma equation_zero_of_raw_zero
    (x : Coefficients K) (hraw : rawPolynomial x = 0)
    (i j : Nat) : coeff (exponent i j) (rawPolynomial x) = 0 := by
  rw [hraw]
  simp

/-- `RawSystem` is exactly coefficient extraction from the internally defined
`Delta - 1`; no external CAS identification remains in this equivalence. -/
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
    have h01 : e01 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h10 : e10 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h02 : e02 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 2; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h11 : e11 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h20 : e20 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 2 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h03 : e03 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 3; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h12 : e12 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 2; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h21 : e21 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 2 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h30 : e30 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 3 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h04 : e04 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 4; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h13 : e13 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 3; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h22 : e22 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 2 2; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h31 : e31 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 3 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h40 : e40 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 4 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h05 : e05 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 0 5; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h14 : e14 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 1 4; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h23 : e23 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 2 3; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h32 : e32 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 3 2; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h41 : e41 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 4 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h50 : e50 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 5 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h24 : e24 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 2 4; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h33 : e33 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 3 3; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h42 : e42 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 4 2; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h51 : e51 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 5 1; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    have h60 : e60 x = 0 := by have hc := equation_zero_of_raw_zero x hraw 6 0; rw [raw_coefficient] at hc; norm_num at hc; exact hc
    exact {
      e01 := by simpa [e01] using h01, e10 := by simpa [e10] using h10,
      e02 := by simpa [e02] using h02, e11 := by simpa [e11] using h11,
      e20 := by simpa [e20] using h20, e03 := by simpa [e03] using h03,
      e12 := by simpa [e12] using h12, e21 := by simpa [e21] using h21,
      e30 := by simpa [e30] using h30, e04 := by simpa [e04] using h04,
      e13 := by simpa [e13] using h13, e22 := by simpa [e22] using h22,
      e31 := by simpa [e31] using h31, e40 := by simpa [e40] using h40,
      e05 := by simpa [e05] using h05, e14 := by simpa [e14] using h14,
      e23 := by simpa [e23] using h23, e32 := by simpa [e32] using h32,
      e41 := by simpa [e41] using h41, e50 := by simpa [e50] using h50,
      e24 := by simpa [e24] using h24, e33 := by simpa [e33] using h33,
      e42 := by simpa [e42] using h42, e51 := by simpa [e51] using h51,
      e60 := by simpa [e60] using h60 }

section EndToEnd

variable [IsAlgClosed K]

/-- Fully internal exclusion of the pure `v`-quadratic family, starting from
the determinant equation for the explicitly defined ansatz. -/
theorem parallel_v_from_delta_distinct_roots
    (x : Coefficients K) (hdelta : delta (pureV x) = 1)
    (hc20ne : x.c20 ≠ 0) (r1 r2 : K) (hr : r1 ≠ r2)
    (hroot1 : 1 + x.c10*r1 + x.c20*r1^2 = 0)
    (hroot2 : 1 + x.c10*r2 + x.c20*r2^2 = 0) : False := by
  exact parallel_v_from_raw_distinct_roots x
    ((rawSystem_iff_delta_eq_one (pureV x)).mpr hdelta)
    hc20ne r1 r2 hr hroot1 hroot2

/-- Fully internal exclusion of the pure `t`-quadratic family, starting from
the determinant equation for the explicitly defined ansatz. -/
theorem parallel_t_from_delta_distinct_roots
    (x : Coefficients K) (hdelta : delta (pureT x) = 1)
    (hc02ne : x.c02 ≠ 0) (r1 r2 : K) (hr : r1 ≠ r2)
    (hroot1 : 1 + x.c01*r1 + x.c02*r1^2 = 0)
    (hroot2 : 1 + x.c01*r2 + x.c02*r2^2 = 0) : False := by
  exact parallel_t_from_raw_distinct_roots x
    ((rawSystem_iff_delta_eq_one (pureT x)).mpr hdelta)
    hc02ne r1 r2 hr hroot1 hroot2

end EndToEnd

#print axioms delta_sub_one_expansion
#print axioms rawSystem_iff_delta_eq_one
#print axioms parallel_v_from_delta_distinct_roots
#print axioms parallel_t_from_delta_distinct_roots

end

end RawDeltaBridge
