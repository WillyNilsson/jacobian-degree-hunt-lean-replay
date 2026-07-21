import Mathlib.Tactic

/-!
# Parallel-line exclusions in the degree-five `t²` branch

This file formalizes the reusable Wronskian and two-root arguments, together
with the two exact Nullstellensatz certificates produced by
`general_t2_attack.py`.  The certificate denominators have been cleared, so
Lean checks polynomial identities with integer coefficients only.
-/

namespace ParallelLinesNoGo

section Structural

variable {K : Type*} [Field K] [CharZero K]

/-- An affine polynomial vanishing at two distinct points is zero. -/
lemma affine_eq_zero_of_two_roots
    (a b r₁ r₂ : K) (hr : r₁ ≠ r₂)
    (h₁ : a + b * r₁ = 0) (h₂ : a + b * r₂ = 0) :
    a = 0 ∧ b = 0 := by
  have hbprod : b * (r₁ - r₂) = 0 := by
    linear_combination h₁ - h₂
  have hdiff : r₁ - r₂ ≠ 0 := sub_ne_zero.mpr hr
  have hb : b = 0 := (mul_eq_zero.mp hbprod).resolve_right hdiff
  subst b
  simpa using h₁

/--
For two quadratics, a constant nonzero Wronskian forces both quadratic
coefficients to vanish.  `h02` and `h12` are exactly the positive-degree
Wronskian coefficient equations.
-/
lemma quadratic_constant_wronskian
    (p0 p1 p2 q0 q1 q2 : K)
    (hdet : p0 * q1 - p1 * q0 ≠ 0)
    (h02 : p0 * q2 - p2 * q0 = 0)
    (h12 : p1 * q2 - p2 * q1 = 0) :
    p2 = 0 ∧ q2 = 0 := by
  have hp : p2 * (p0 * q1 - p1 * q0) = 0 := by
    linear_combination -p0 * h12 + p1 * h02
  have hq : q2 * (p0 * q1 - p1 * q0) = 0 := by
    linear_combination -q0 * h12 + q1 * h02
  exact ⟨(mul_eq_zero.mp hp).resolve_right hdet,
    (mul_eq_zero.mp hq).resolve_right hdet⟩

/--
For two cubics, a constant nonzero Wronskian forces both polynomials to be
affine-linear.  The five hypotheses after `hdet` are the coefficients of
degrees one through four in the Wronskian.
-/
lemma cubic_constant_wronskian
    (p0 p1 p2 p3 q0 q1 q2 q3 : K)
    (hdet : p0 * q1 - p1 * q0 ≠ 0)
    (h02 : p0 * q2 - p2 * q0 = 0)
    (hmiddle : 3 * (p0 * q3 - p3 * q0) + (p1 * q2 - p2 * q1) = 0)
    (h13 : p1 * q3 - p3 * q1 = 0)
    (h23 : p2 * q3 - p3 * q2 = 0) :
    p2 = 0 ∧ p3 = 0 ∧ q2 = 0 ∧ q3 = 0 := by
  let D : K := p0 * q1 - p1 * q0
  let A : K := p2 * q1 - p1 * q2
  let B : K := p0 * q3 - p3 * q0
  have hD : D ≠ 0 := by simpa [D] using hdet
  have hAB : A * B = 0 := by
    calc
      A * B = D * (p2 * q3 - p3 * q2)
          - (p0 * q2 - p2 * q0) * (p1 * q3 - p3 * q1) := by
            simp [A, B, D]
            ring
      _ = 0 := by rw [h23, h02, h13]; ring
  have hAeq : A = 3 * B := by
    dsimp [A, B]
    linear_combination -hmiddle
  have hB : B = 0 := by
    rw [hAeq] at hAB
    rcases mul_eq_zero.mp hAB with hthreeB | hB
    · rcases mul_eq_zero.mp hthreeB with hthree | hB
      · norm_num at hthree
      · exact hB
    · exact hB
  have hA : A = 0 := by rw [hAeq, hB]; ring
  have hp2D : p2 * D = 0 := by
    dsimp [A, D] at hA ⊢
    linear_combination p0 * hA + p1 * h02
  have hq2D : q2 * D = 0 := by
    dsimp [A, D] at hA ⊢
    linear_combination q0 * hA + q1 * h02
  have hp3D : p3 * D = 0 := by
    dsimp [B, D] at hB ⊢
    linear_combination -p0 * h13 + p1 * hB
  have hq3D : q3 * D = 0 := by
    dsimp [B, D] at hB ⊢
    linear_combination -q0 * h13 + q1 * hB
  exact ⟨(mul_eq_zero.mp hp2D).resolve_right hD,
    (mul_eq_zero.mp hp3D).resolve_right hD,
    (mul_eq_zero.mp hq2D).resolve_right hD,
    (mul_eq_zero.mp hq3D).resolve_right hD⟩

/-- The two distinct parallel `v`-lines kill both affine top coefficients. -/
theorem parallel_v_two_root_vanishing
    (a02 a12 b02 b12 r₁ r₂ : K) (hr : r₁ ≠ r₂)
    (ha₁ : a02 + a12 * r₁ = 0) (ha₂ : a02 + a12 * r₂ = 0)
    (hb₁ : b02 + b12 * r₁ = 0) (hb₂ : b02 + b12 * r₂ = 0) :
    a02 = 0 ∧ a12 = 0 ∧ b02 = 0 ∧ b12 = 0 := by
  obtain ⟨ha02, ha12⟩ := affine_eq_zero_of_two_roots a02 a12 r₁ r₂ hr ha₁ ha₂
  obtain ⟨hb02, hb12⟩ := affine_eq_zero_of_two_roots b02 b12 r₁ r₂ hr hb₁ hb₂
  exact ⟨ha02, ha12, hb02, hb12⟩

end Structural

section Certificates

variable {K : Type*} [Field K] [CharZero K]

/-- Exact unit-ideal certificate for `gamma = 1 + c10*v + v²`. -/
theorem normalized_parallel_v_certificate
    (b11 b21 c10 : K)
    (e1 : 10*b11^2*b21 + 15*b11*b21*c10 - 10*b21^2
      + 30*b21*c10^2 - 30*b21 = 0)
    (e2 : 10*b11^3 + 8*b11^2*b21*c10 + 15*b11^2*c10
      + 12*b11*b21*c10^2 - 22*b11*b21 + 30*b11*c10^2 - 30*b11
      - 8*b21^2*c10 + 24*b21*c10^3 - 48*b21*c10 = 0)
    (e3 : 8*b11^3*c10 + 6*b11^2*b21 + 12*b11^2*c10^2 - 2*b11^2
      - 8*b11*b21*c10 + 24*b11*c10^3 - 33*b11*c10
      - 6*b21^2 - 10*b21 + 30*c10^2 - 30 = 0)
    (e4 : 6*b11^3 + 8*b11^2*c10 - 12*b11*b21 + 12*b11*c10^2
      - 12*b11 - 8*b21*c10 + 24*c10^3 - 48*c10 = 0) : False := by
  have hcontra : (7776000 : K) = 0 := by
    linear_combination
      -(720*b11^4*b21 - 6675*b11^4 - 3420*b11^3*b21*c10
        - 16362*b11^3*c10 - 720*b11^2*b21^2 + 2520*b11^2*b21*c10^2
        + 2900*b11^2*b21 - 24336*b11^2*c10^2 + 17090*b11^2
        + 2535*b11*b21^2*c10 + 26664*b11*b21*c10 - 13824*b11*c10^3
        + 16704*b11*c10 - 1428*b21^3*c10^2 + 1428*b21^3
        - 6720*b21^2*c10^2 + 9100*b21^2 + 26496*b21*c10^2
        - 4700*b21 - 165888*c10^4 + 418176*c10^2 - 91200) * e1
      - 5*(360*b11^4*c10 + 1335*b11^3*b21 + 720*b11^3*c10^2
        - 270*b11^3 - 630*b11^2*b21*c10 + 1764*b11^2*c10
        - 844*b11*b21^2 - 3670*b11*b21 + 3456*b11*c10^2
        - 2076*b11 + 357*b21^3*c10 + 1680*b21^2*c10
        - 6624*b21*c10 + 41472*c10^3 - 80424*c10) * e2
      + 10*(225*b11^4 + 180*b11^3*b21*c10 + 450*b11^3*c10
        + 120*b11^2*b21^2 + 360*b11^2*b21*c10^2 - 2574*b11^2*b21
        + 690*b11^2 - 2160*b11*b21*c10 + 1260*b11*c10
        + 238*b21^3 + 1834*b21^2 - 480*b21 + 25920*c10^2 - 25920) * e3
      + 30*(40*b11^3*b21^2 - 75*b11^3*b21 - 50*b11^3
        - 150*b11^2*b21*c10 + 300*b11^2*c10 - 40*b11*b21^3
        + 238*b11*b21^2 - 546*b11*b21 - 2892*b21*c10 - 10800*c10) * e4
  exact (by norm_num : (7776000 : K) ≠ 0) hcontra

/-- Exact unit-ideal certificate for `gamma = 1 + c01*t + t²`. -/
theorem normalized_parallel_t_certificate
    (b02 c01 : K)
    (e1 : 16*b02^3 + 20*b02^2*c01 + 16*b02*c01^2 - 12*b02 = 0)
    (e2 : 12*b02^3*c01 + 15*b02^2*c01^2 + 4*b02^2
      + 12*b02*c01^3 - 2*b02*c01 + 12*c01^2 - 9 = 0)
    (e3 : 8*b02^3 + 12*b02^2*c01 + 12*b02*c01^2 - 8*b02
      + 8*c01^3 - 12*c01 = 0) : False := by
  have hcontra : (5184 : K) = 0 := by
    linear_combination
      -(189*b02^2*c01^3 - 408*b02^2*c01 + 60*b02*c01^2
        - 176*b02 + 576*c01^3 - 1017*c01) * e1
      + 4*(63*b02^2*c01^2 - 80*b02^2 + 13*b02*c01
        + 192*c01^2 - 144) * e2
      - 48*(7*b02^2*c01 + 4*b02 + 24*c01) * e3
  exact (by norm_num : (5184 : K) ≠ 0) hcontra

#print axioms affine_eq_zero_of_two_roots
#print axioms quadratic_constant_wronskian
#print axioms cubic_constant_wronskian
#print axioms parallel_v_two_root_vanishing
#print axioms normalized_parallel_v_certificate
#print axioms normalized_parallel_t_certificate

end Certificates

end ParallelLinesNoGo
