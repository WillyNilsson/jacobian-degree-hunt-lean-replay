import LeanFormalization.FullCubicScaffold

/-!
# Polynomial-level linear covariance

`MixedGammaIdentities` proves the determinant covariance identity for values
and derivative values.  This file supplies the missing polynomial layer: an
actual linear substitution in two variables, its two chain rules, and source
and target covariance for the full determinant polynomial.

No invertibility hypothesis is required for covariance itself.  In later
normal-form arguments the two matrices will be invertible and their
determinants will be chosen to cancel.
-/

namespace MixedGammaFull.GL2Covariance

open MvPolynomial FullCubicScaffold

variable {K : Type*} [Field K] [CharZero K]

noncomputable section

/-- Substitute
`v_old = p*v + q*t` and `t_old = r*v + s*t` into a bivariate polynomial. -/
def linearSub (p q r s : K) : Bivar K →ₐ[K] Bivar K :=
  bind₁ fun i => if i = 0 then C p * v + C q * t else C r * v + C s * t

@[simp] theorem linearSub_v (p q r s : K) :
    linearSub p q r s v = C p * v + C q * t := by
  simp [linearSub, v]

@[simp] theorem linearSub_t (p q r s : K) :
    linearSub p q r s t = C r * v + C s * t := by
  simp [linearSub, t]

/-- Chain rule for differentiation in the new `v` coordinate. -/
theorem pderiv_v_linearSub (p q r s : K) (f : Bivar K) :
    pderiv 0 (linearSub p q r s f) =
      C p * linearSub p q r s (pderiv 0 f) +
      C r * linearSub p q r s (pderiv 1 f) := by
  induction f using MvPolynomial.induction_on with
  | C a => simp [linearSub]
  | add f g hf hg =>
      simp only [map_add, hf, hg]
      ring
  | mul_X f i hf =>
      rw [map_mul, Derivation.leibniz, hf]
      fin_cases i <;> simp [linearSub, v, t] <;> ring

/-- Chain rule for differentiation in the new `t` coordinate. -/
theorem pderiv_t_linearSub (p q r s : K) (f : Bivar K) :
    pderiv 1 (linearSub p q r s f) =
      C q * linearSub p q r s (pderiv 0 f) +
      C s * linearSub p q r s (pderiv 1 f) := by
  induction f using MvPolynomial.induction_on with
  | C a => simp [linearSub]
  | add f g hf hg =>
      simp only [map_add, hf, hg]
      ring
  | mul_X f i hf =>
      rw [map_mul, Derivation.leibniz, hf]
      fin_cases i <;> simp [linearSub, v, t] <;> ring

/-- The determinant expression for three arbitrary bivariate polynomials. -/
def deltaPoly (A B G : Bivar K) : Bivar K :=
  G * bracket A B + B * bracket A G + A * bracket G B

/-- Linear source substitution scales the full determinant polynomial by the
determinant of the source matrix. -/
theorem source_covariance (p q r s : K) (A B G : Bivar K) :
    deltaPoly (linearSub p q r s A) (linearSub p q r s B)
        (linearSub p q r s G) =
      C (p * s - q * r) * linearSub p q r s (deltaPoly A B G) := by
  unfold deltaPoly bracket
  rw [pderiv_v_linearSub, pderiv_t_linearSub,
    pderiv_v_linearSub, pderiv_t_linearSub,
    pderiv_v_linearSub, pderiv_t_linearSub]
  simp only [map_add, map_sub, map_mul]
  ring

/-- A linear change of the `(A,B)` target slots scales the full determinant
polynomial by the determinant of the target matrix. -/
theorem target_covariance (a b c d : K) (A B G : Bivar K) :
    deltaPoly (C a * A + C b * B) (C c * A + C d * B) G =
      C (a * d - b * c) * deltaPoly A B G := by
  unfold deltaPoly bracket
  simp only [map_add, MvPolynomial.pderiv_mul, map_mul, pderiv_C,
    zero_mul, zero_add]
  have hC : C (a * d - b * c) =
      (C a * C d - C b * C c : Bivar K) := by simp
  rw [hC]
  ring

/-- Combined source and target covariance.  This is the exact polynomial
identity used when a conic is put into normal form and the normalized linear
jets of `(alpha,beta)` are restored. -/
theorem source_target_covariance
    (p q r s a b c d : K) (A B G : Bivar K) :
    deltaPoly
        (C a * linearSub p q r s A + C b * linearSub p q r s B)
        (C c * linearSub p q r s A + C d * linearSub p q r s B)
        (linearSub p q r s G) =
      C ((a * d - b * c) * (p * s - q * r)) *
        linearSub p q r s (deltaPoly A B G) := by
  rw [target_covariance, source_covariance]
  simp only [map_mul, map_sub]
  ring

/-- If the two determinant factors cancel, the Keller equation is preserved. -/
theorem preserves_one
    (p q r s a b c d : K) (A B G : Bivar K)
    (hdet : (a * d - b * c) * (p * s - q * r) = 1)
    (hDelta : deltaPoly A B G = 1) :
    deltaPoly
        (C a * linearSub p q r s A + C b * linearSub p q r s B)
        (C c * linearSub p q r s A + C d * linearSub p q r s B)
        (linearSub p q r s G) = 1 := by
  rw [source_target_covariance, hdet, hDelta]
  simp

#print axioms pderiv_v_linearSub
#print axioms pderiv_t_linearSub
#print axioms source_covariance
#print axioms target_covariance
#print axioms source_target_covariance
#print axioms preserves_one

end

end MixedGammaFull.GL2Covariance
