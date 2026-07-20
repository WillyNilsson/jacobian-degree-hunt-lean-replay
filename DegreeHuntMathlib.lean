import Mathlib.RingTheory.Polynomial.Wronskian
import Mathlib.RingTheory.EuclideanDomain
import Mathlib.Algebra.Polynomial.FieldDivision
import Mathlib.Tactic.Ring

set_option maxHeartbeats 1000000

open scoped Polynomial

noncomputable section

namespace DegreeHuntMathlib

open Polynomial

variable {K : Type*} [Field K] [CharZero K]

def antiW (A B : K[X]) : K[X] := derivative A * B - A * derivative B

omit [CharZero K] in
lemma antiW_eq_neg_wronskian (A B : K[X]) :
    antiW A B = -wronskian A B := by
  simp [antiW, wronskian]

/-- A normalized Wronskian-zero pair cannot have a nonzero left member.
This is the algebraic heart of the no-go theorem's `A = 0` step. -/
lemma antiW_normalized_left_eq_zero
    (A B : K[X])
    (hW : antiW A B = 0)
    (hA0 : A.coeff 0 = 0)
    (hB0 : B.coeff 0 = 1) :
    A = 0 := by
  letI := Classical.decEq K[X]
  letI := EuclideanDomain.gcdMonoid K[X]
  have hB : B ≠ 0 := by
    intro h
    have : B.coeff 0 = 0 := by simp [h]
    rw [hB0] at this
    exact one_ne_zero this
  let d := GCDMonoid.gcd A B
  let A₁ := A / d
  let B₁ := B / d
  have hd : d ≠ 0 := gcd_ne_zero_of_right hB
  have hAf : d * A₁ = A := by
    exact EuclideanDomain.mul_div_cancel' hd (gcd_dvd_left A B)
  have hBf : d * B₁ = B := by
    exact EuclideanDomain.mul_div_cancel' hd (gcd_dvd_right A B)
  have hcop : IsCoprime A₁ B₁ := isCoprime_div_gcd_div_gcd hB
  have hW₁ : antiW A₁ B₁ = 0 := by
    have hprod : d ^ 2 * antiW A₁ B₁ = 0 := by
      rw [← hW]
      rw [← hAf, ← hBf]
      simp [antiW, derivative_mul]
      ring
    exact (mul_eq_zero.mp hprod).resolve_left (pow_ne_zero 2 hd)
  have hWr : wronskian A₁ B₁ = 0 := by
    have := hW₁
    rw [antiW_eq_neg_wronskian] at this
    exact neg_eq_zero.mp this
  have hdA₁ : derivative A₁ = 0 :=
    (hcop.wronskian_eq_zero_iff.mp hWr).1
  have ha : A₁ = C (A₁.coeff 0) := eq_C_of_derivative_eq_zero hdA₁
  have hA₁0 : A₁.coeff 0 = 0 := by
    have hc := congrArg (fun p : K[X] => p.coeff 0) hAf
    have hcB := congrArg (fun p : K[X] => p.coeff 0) hBf
    simp only [mul_coeff_zero, hA0, hB0] at hc hcB
    have hd0 : d.coeff 0 ≠ 0 := by
      intro hz
      rw [hz, zero_mul] at hcB
      exact zero_ne_one hcB
    exact (mul_eq_zero.mp hc).resolve_left hd0
  have hA₁ : A₁ = 0 := by rw [ha, hA₁0, C_0]
  calc
    A = d * A₁ := hAf.symm
    _ = 0 := by rw [hA₁, mul_zero]

/-- The complete case split used in the linear-in-`t` no-go theorem.

The three hypotheses `h2`, `h1`, and `h0` are exactly the `t²`, `t`, and
constant coefficients of `Delta = 1`.  The conclusion says that the
`t`-coefficient `G` in `gamma` and the `t`-coefficient `A` in `alpha`
must vanish, and records the remaining constant-coefficient equation. -/
theorem t_linear_core_no_go
    (a A b B g G : K[X])
    (ha0 : a.coeff 0 = 0)
    (ha1 : a.coeff 1 = 1)
    (hA0 : A.coeff 0 = 0)
    (hB0 : B.coeff 0 = 1)
    (hg0 : g.coeff 0 = 1)
    (h2 : G * (derivative A * B - A * derivative B) = 0)
    (h1 :
      g * (derivative A * B - A * derivative B)
      + G * (derivative a * B - A * derivative b)
      + B * (derivative a * G - A * derivative g)
      + b * (derivative A * G - A * derivative G)
      + a * (derivative G * B - G * derivative B)
      + A * (derivative g * B - G * derivative b) = 0)
    (h0 :
      g * (derivative a * B - A * derivative b)
      + b * (derivative a * G - A * derivative g)
      + a * (derivative g * B - G * derivative b) = 1) :
    G = 0 ∧ A = 0 ∧ B * derivative (g * a) = 1 := by
  have ha_ne : a ≠ 0 := by
    intro ha
    have : a.coeff 1 = 0 := by simp [ha]
    rw [ha1] at this
    exact one_ne_zero this
  have hg_ne : g ≠ 0 := by
    intro hg
    have : g.coeff 0 = 0 := by simp [hg]
    rw [hg0] at this
    exact one_ne_zero this
  by_cases hG : G = 0
  · have hAWprod : g * antiW A B = 0 := by
      have hh := h1
      simp [hG] at hh
      rw [antiW]
      calc
        g * (derivative A * B - A * derivative B) =
            g * (derivative A * B - A * derivative B)
              - B * A * derivative g + A * derivative g * B := by ring
        _ = 0 := by
          convert hh using 1
          all_goals ring
    have hAW : antiW A B = 0 :=
      (mul_eq_zero.mp hAWprod).resolve_left hg_ne
    have hA : A = 0 := antiW_normalized_left_eq_zero A B hAW hA0 hB0
    refine ⟨hG, hA, ?_⟩
    have hh := h0
    simp [hG, hA] at hh
    rw [derivative_mul]
    calc
      B * (derivative g * a + g * derivative a) =
          g * (derivative a * B) + a * (derivative g * B) := by ring
      _ = 1 := hh
  · have hAW : antiW A B = 0 := by
      exact (mul_eq_zero.mp h2).resolve_left hG
    have hA : A = 0 := antiW_normalized_left_eq_zero A B hAW hA0 hB0
    have hlin :
        2 * derivative a * B * G
          + a * (derivative G * B - G * derivative B) = 0 := by
      have hh := h1
      simp [hA] at hh
      calc
        2 * derivative a * B * G
              + a * (derivative G * B - G * derivative B) =
            G * (derivative a * B) + B * (derivative a * G)
              + a * (derivative G * B - G * derivative B) := by ring
        _ = 0 := hh
    let U : K[X] := G * a ^ 2
    have hUW : antiW U B = 0 := by
      have hid : antiW U B = a *
          (2 * derivative a * B * G
            + a * (derivative G * B - G * derivative B)) := by
        simp [U, antiW, derivative_mul, derivative_pow]
        have hC2 : (C (2 : K) : K[X]) = 2 := C_ofNat 2
        rw [hC2]
        ring
      rw [hid, hlin, mul_zero]
    have hU0 : U.coeff 0 = 0 := by
      have hpow : (a ^ 2).coeff 0 = (a.coeff 0) ^ 2 := by
        simpa only [constantCoeff_apply] using
          (map_pow (constantCoeff (R := K)) a 2)
      calc
        U.coeff 0 = G.coeff 0 * (a ^ 2).coeff 0 := by
          simp [U, mul_coeff_zero]
        _ = G.coeff 0 * (a.coeff 0) ^ 2 := by rw [hpow]
        _ = 0 := by rw [ha0]; ring
    have hU : U = 0 := antiW_normalized_left_eq_zero U B hUW hU0 hB0
    have ha2 : a ^ 2 ≠ 0 := pow_ne_zero 2 ha_ne
    have : G * a ^ 2 ≠ 0 := mul_ne_zero hG ha2
    exact (this (by simpa [U] using hU)).elim

#print axioms t_linear_core_no_go

/-- The remaining equation forces `g` to be the constant polynomial `1`. -/
lemma gamma_constant_of_remaining_equation
    (a B g : K[X])
    (ha0 : a.coeff 0 = 0)
    (ha1 : a.coeff 1 = 1)
    (hg0 : g.coeff 0 = 1)
    (hprod : B * derivative (g * a) = 1) :
    g = 1 := by
  have hpunit : IsUnit (derivative (g * a)) :=
    IsUnit.of_mul_eq_one_right B hprod
  have hder0 : (derivative (g * a)).natDegree = 0 :=
    natDegree_eq_zero_of_isUnit hpunit
  have hga1 : (g * a).coeff 1 = 1 := by
    rw [mul_coeff_one, ha0, ha1, hg0]
    ring
  have hga_ge : 1 ≤ (g * a).natDegree :=
    le_natDegree_of_ne_zero (hga1.symm ▸ one_ne_zero)
  have hga_le : (g * a).natDegree ≤ 1 := by
    have hder := natDegree_derivative (g * a)
    rw [hder0] at hder
    omega
  have hga_deg : (g * a).natDegree = 1 :=
    Nat.le_antisymm hga_le hga_ge
  have ha_ne : a ≠ 0 := by
    intro ha
    have : a.coeff 1 = 0 := by simp [ha]
    rw [ha1] at this
    exact one_ne_zero this
  have hg_ne : g ≠ 0 := by
    intro hg
    have : g.coeff 0 = 0 := by simp [hg]
    rw [hg0] at this
    exact one_ne_zero this
  have ha_ge : 1 ≤ a.natDegree :=
    le_natDegree_of_ne_zero (ha1.symm ▸ one_ne_zero)
  have hmuldeg : (g * a).natDegree = g.natDegree + a.natDegree :=
    natDegree_mul hg_ne ha_ne
  have hgdeg : g.natDegree = 0 := by omega
  calc
    g = C (g.coeff 0) := eq_C_of_natDegree_eq_zero hgdeg
    _ = C 1 := by rw [hg0]
    _ = 1 := C_1

/-- Final no-go statement at the coefficient-equation level: a normalized
linear-in-`t` Keller solution has constant `gamma = 1`. -/
theorem t_linear_no_go
    (a A b B g G : K[X])
    (ha0 : a.coeff 0 = 0)
    (ha1 : a.coeff 1 = 1)
    (hA0 : A.coeff 0 = 0)
    (hB0 : B.coeff 0 = 1)
    (hg0 : g.coeff 0 = 1)
    (h2 : G * (derivative A * B - A * derivative B) = 0)
    (h1 :
      g * (derivative A * B - A * derivative B)
      + G * (derivative a * B - A * derivative b)
      + B * (derivative a * G - A * derivative g)
      + b * (derivative A * G - A * derivative G)
      + a * (derivative G * B - G * derivative B)
      + A * (derivative g * B - G * derivative b) = 0)
    (h0 :
      g * (derivative a * B - A * derivative b)
      + b * (derivative a * G - A * derivative g)
      + a * (derivative g * B - G * derivative b) = 1) :
    G = 0 ∧ A = 0 ∧ g = 1 := by
  obtain ⟨hG, hA, hprod⟩ :=
    t_linear_core_no_go a A b B g G ha0 ha1 hA0 hB0 hg0 h2 h1 h0
  exact ⟨hG, hA, gamma_constant_of_remaining_equation a B g ha0 ha1 hg0 hprod⟩

#print axioms gamma_constant_of_remaining_equation
#print axioms t_linear_no_go

/-- Same theorem with the literal `t²` coefficient `2*G*W(A,B)=0`
that comes from expanding `Delta = 1`. -/
theorem t_linear_no_go_from_literal_coefficients
    (a A b B g G : K[X])
    (ha0 : a.coeff 0 = 0)
    (ha1 : a.coeff 1 = 1)
    (hA0 : A.coeff 0 = 0)
    (hB0 : B.coeff 0 = 1)
    (hg0 : g.coeff 0 = 1)
    (h2 : 2 * G * (derivative A * B - A * derivative B) = 0)
    (h1 :
      g * (derivative A * B - A * derivative B)
      + G * (derivative a * B - A * derivative b)
      + B * (derivative a * G - A * derivative g)
      + b * (derivative A * G - A * derivative G)
      + a * (derivative G * B - G * derivative B)
      + A * (derivative g * B - G * derivative b) = 0)
    (h0 :
      g * (derivative a * B - A * derivative b)
      + b * (derivative a * G - A * derivative g)
      + a * (derivative g * B - G * derivative b) = 1) :
    G = 0 ∧ A = 0 ∧ g = 1 := by
  have htwo : (2 : K[X]) ≠ 0 := by norm_num
  have h2' : G * (derivative A * B - A * derivative B) = 0 := by
    exact (mul_eq_zero.mp (by simpa [mul_assoc] using h2)).resolve_left htwo
  exact t_linear_no_go a A b B g G ha0 ha1 hA0 hB0 hg0 h2' h1 h0

#print axioms t_linear_no_go_from_literal_coefficients

end DegreeHuntMathlib
