import DiagonalReduction

/-!
# Discharging the parallel-line Wronskian hypotheses from the raw system

This file closes the remaining Wronskian wiring gap.  For each root of the
pure quadratic factor, exact polynomial combinations of `RawSystem` and the
root equation give the constant-Wronskian identities for the corresponding
contracted line.  Distinct roots make the derivative nonzero, so the abstract
Wronskian lemmas force the top coefficients to vanish.  The already checked
diagonal-normalization and certificate theorems then give the contradiction.
-/

namespace WronskianDischarge

open DiagonalReduction

variable {K : Type*} [Field K] [CharZero K]

/-- Set the three coefficients excluded by the pure `v`-quadratic family. -/
def pureV (x : Coefficients K) : Coefficients K :=
  { x with c01 := 0, c11 := 0, c02 := 0 }

/-- Set the three coefficients excluded by the pure `t`-quadratic family. -/
def pureT (x : Coefficients K) : Coefficients K :=
  { x with c10 := 0, c20 := 0, c11 := 0 }

/-- A nondegenerate quadratic with two distinct roots has nonzero derivative
at each root. -/
lemma quadratic_derivatives_ne_zero
    (c d r1 r2 : K) (hd : d ≠ 0) (hr : r1 ≠ r2)
    (h1 : 1 + c*r1 + d*r1^2 = 0)
    (h2 : 1 + c*r2 + d*r2^2 = 0) :
    c + 2*d*r1 ≠ 0 ∧ c + 2*d*r2 ≠ 0 := by
  have first_root
      (u1 u2 : K) (hu : u1 ≠ u2)
      (hu1 : 1 + c*u1 + d*u1^2 = 0)
      (hu2 : 1 + c*u2 + d*u2^2 = 0) : c + 2*d*u1 ≠ 0 := by
    have hfactor : (u1-u2) * (c + d*(u1+u2)) = 0 := by
      linear_combination hu1 - hu2
    have hsum : c + d*(u1+u2) = 0 :=
      (mul_eq_zero.mp hfactor).resolve_left (sub_ne_zero.mpr hu)
    intro hderiv
    have hprod : d * (u1-u2) = 0 := by
      linear_combination hderiv - hsum
    have : u1-u2 = 0 := (mul_eq_zero.mp hprod).resolve_left hd
    exact (sub_ne_zero.mpr hu) this
  exact ⟨first_root r1 r2 hr h1 h2,
    first_root r2 r1 (Ne.symm hr) h2 h1⟩

section VFamily

/-- At a root of the pure `v`-quadratic, the raw equations imply that both
quadratic restriction coefficients vanish.  The three `linear_combination`
blocks are exact regenerated column identities for degrees 0, 1, and 2 in
the free parameter `t`. -/
lemma v_root_top_coefficients
    (x : Coefficients K) (h : RawSystem (pureV x)) (r : K)
    (hroot : 1 + x.c10*r + x.c20*r^2 = 0)
    (hderiv : x.c10 + 2*x.c20*r ≠ 0) :
    x.a02 + x.a12*r = 0 ∧ x.b02 + x.b12*r = 0 := by
  have e01 := h.e01
  have e10 := h.e10
  have e02 := h.e02
  have e11 := h.e11
  have e20 := h.e20
  have e12 := h.e12
  have e21 := h.e21
  have e22 := h.e22
  have e30 := h.e30
  have e31 := h.e31
  have e32 := h.e32
  have e40 := h.e40
  have e41 := h.e41
  have e42 := h.e42
  have e50 := h.e50
  have e51 := h.e51
  have e60 := h.e60
  simp [pureV] at e01 e10 e02 e11 e20 e12 e21 e22 e30 e31 e32
    e40 e41 e42 e50 e51 e60
  let p0 := r + x.a20*r^2 + x.a30*r^3
  let p1 := x.a11*r + x.a21*r^2
  let p2 := x.a02 + x.a12*r
  let q0 := x.b20*r^2 + x.b30*r^3
  let q1 := 1 + x.b11*r + x.b21*r^2
  let q2 := x.b02 + x.b12*r
  let D := p0*q1 - p1*q0
  let H02 := p0*q2 - p2*q0
  let H12 := p1*q2 - p2*q1
  have hconstant : (x.c10 + 2*x.c20*r)*D - 1 = 0 := by
    dsimp [D, p0, p1, q0, q1]
    linear_combination
      r*e10 + r^2*e20 + r^3*e30 + r^4*e40 + r^5*e50 + r^6*e60
      + (2*x.a11*x.b20*r^2 + 3*x.a11*x.b30*r^3
        - 2*x.a20*x.b11*r^2 - 2*x.a20*x.b21*r^3 - 2*x.a20*r
        + 2*x.a21*x.b20*r^3 + 3*x.a21*x.b30*r^4
        - 3*x.a30*x.b11*r^3 - 3*x.a30*x.b21*r^4 - 3*x.a30*r^2
        - x.b11*r - x.b21*r^2 - 1) * hroot
  have h02scaled : 2*(x.c10 + 2*x.c20*r)*H02 = 0 := by
    dsimp [H02, p0, p2, q0, q2]
    linear_combination
      e01 + r*e11 + r^2*e21 + r^3*e31 + r^4*e41 + r^5*e51
      + (4*x.a02*x.b20*r + 6*x.a02*x.b30*r^2
        + x.a11*x.b21*r^2 - x.a11
        + 4*x.a12*x.b20*r^2 + 6*x.a12*x.b30*r^3
        - 4*x.a20*x.b02*r - 4*x.a20*x.b12*r^2
        - x.a21*x.b11*r^2 - 2*x.a21*r
        - 6*x.a30*x.b02*r^2 - 6*x.a30*x.b12*r^3
        - 2*x.b02 - 2*x.b12*r) * hroot
  have h12scaled : (x.c10 + 2*x.c20*r)*H12 = 0 := by
    dsimp [H12, p1, p2, q1, q2]
    linear_combination
      e02 + r*e12 + r^2*e22 + r^3*e32 + r^4*e42
      + (2*x.a02*x.b11 + 4*x.a02*x.b21*r
        - 2*x.a11*x.b02 - x.a11*x.b12*r
        + x.a12*x.b11*r + 3*x.a12*x.b21*r^2 - x.a12
        - 4*x.a21*x.b02*r - 3*x.a21*x.b12*r^2) * hroot
  have hdet : D ≠ 0 := by
    intro hD
    rw [hD] at hconstant
    norm_num at hconstant
  have h02 : H02 = 0 := by
    have hleft : 2*(x.c10 + 2*x.c20*r) ≠ 0 :=
      mul_ne_zero (by norm_num) hderiv
    exact (mul_eq_zero.mp h02scaled).resolve_left hleft
  have h12 : H12 = 0 :=
    (mul_eq_zero.mp h12scaled).resolve_left hderiv
  have htop := ParallelLinesNoGo.quadratic_constant_wronskian
    p0 p1 p2 q0 q1 q2 hdet h02 h12
  simpa [p2, q2] using htop

end VFamily

section TFamily

/-- At a root of the pure `t`-quadratic, the raw equations imply that both
cubic restrictions are affine-linear.  The five exact combinations are the
regenerated columns of degrees 0 through 4 in the free parameter `v`. -/
lemma t_root_top_coefficients
    (x : Coefficients K) (h : RawSystem (pureT x)) (r : K)
    (hroot : 1 + x.c01*r + x.c02*r^2 = 0)
    (hderiv : x.c01 + 2*x.c02*r ≠ 0) :
    x.a20 + x.a21*r = 0 ∧ x.a30 = 0 ∧
      x.b20 + x.b21*r = 0 ∧ x.b30 = 0 := by
  have e01 := h.e01
  have e02 := h.e02
  have e03 := h.e03
  have e04 := h.e04
  have e05 := h.e05
  have e10 := h.e10
  have e11 := h.e11
  have e12 := h.e12
  have e13 := h.e13
  have e14 := h.e14
  have e20 := h.e20
  have e21 := h.e21
  have e22 := h.e22
  have e23 := h.e23
  have e24 := h.e24
  have e30 := h.e30
  have e31 := h.e31
  have e32 := h.e32
  have e33 := h.e33
  have e40 := h.e40
  have e41 := h.e41
  have e42 := h.e42
  simp [pureT] at e01 e02 e03 e04 e05 e10 e11 e12 e13 e14 e20 e21
    e22 e23 e24 e30 e31 e32 e33 e40 e41 e42
  let p0 := x.a02*r^2
  let p1 := 1 + x.a11*r + x.a12*r^2
  let p2 := x.a20 + x.a21*r
  let p3 := x.a30
  let q0 := r + x.b02*r^2
  let q1 := x.b11*r + x.b12*r^2
  let q2 := x.b20 + x.b21*r
  let q3 := x.b30
  let D := p0*q1 - p1*q0
  let H02 := p0*q2 - p2*q0
  let Hmiddle := 3*(p0*q3 - p3*q0) + (p1*q2 - p2*q1)
  let H13 := p1*q3 - p3*q1
  let H23 := p2*q3 - p3*q2
  have hconstant : -(x.c01 + 2*x.c02*r)*D - 1 = 0 := by
    dsimp [D, p0, p1, q0, q1]
    linear_combination
      r*e01 + r^2*e02 + r^3*e03 + r^4*e04 + r^5*e05
      + (2*x.a02*x.b11*r^2 + 2*x.a02*x.b12*r^3
        - 2*x.a11*x.b02*r^2 - x.a11*r
        - 2*x.a12*x.b02*r^3 - x.a12*r^2
        - 2*x.b02*r - 1) * hroot
  have h02scaled : -2*(x.c01 + 2*x.c02*r)*H02 = 0 := by
    dsimp [H02, p0, p2, q0, q2]
    linear_combination
      e10 + r*e11 + r^2*e12 + r^3*e13 + r^4*e14
      + (4*x.a02*x.b20*r + 4*x.a02*x.b21*r^2
        - x.a11*x.b12*r^2 + x.a12*x.b11*r^2
        - 4*x.a20*x.b02*r - 2*x.a20
        - 4*x.a21*x.b02*r^2 - 2*x.a21*r
        - x.b11 - 2*x.b12*r) * hroot
  have hmiddleScaled : -(x.c01 + 2*x.c02*r)*Hmiddle = 0 := by
    dsimp [Hmiddle, p0, p1, p2, p3, q0, q1, q2, q3]
    linear_combination
      e20 + r*e21 + r^2*e22 + r^3*e23 + r^4*e24
      + (6*x.a02*x.b30*r + 2*x.a11*x.b20 + x.a11*x.b21*r
        + 4*x.a12*x.b20*r + 3*x.a12*x.b21*r^2
        - 2*x.a20*x.b11 - 4*x.a20*x.b12*r
        - x.a21*x.b11*r - 3*x.a21*x.b12*r^2
        - 6*x.a30*x.b02*r - 3*x.a30 - x.b21) * hroot
  have h13scaled : -2*(x.c01 + 2*x.c02*r)*H13 = 0 := by
    dsimp [H13, p1, p3, q1, q3]
    linear_combination
      e30 + r*e31 + r^2*e32 + r^3*e33
      + (3*x.a11*x.b30 + 6*x.a12*x.b30*r
        - 2*x.a20*x.b21 + 2*x.a21*x.b20
        - 3*x.a30*x.b11 - 6*x.a30*x.b12*r) * hroot
  have h23scaled : -(x.c01 + 2*x.c02*r)*H23 = 0 := by
    dsimp [H23, p2, p3, q2, q3]
    linear_combination
      e40 + r*e41 + r^2*e42
      + 3*(x.a21*x.b30 - x.a30*x.b21) * hroot
  have hdet : D ≠ 0 := by
    intro hD
    rw [hD] at hconstant
    norm_num at hconstant
  have h02 : H02 = 0 := by
    have hleft : -2*(x.c01 + 2*x.c02*r) ≠ 0 :=
      mul_ne_zero (by norm_num) hderiv
    exact (mul_eq_zero.mp h02scaled).resolve_left hleft
  have hmiddle : Hmiddle = 0 := by
    have hleft : -(x.c01 + 2*x.c02*r) ≠ 0 := neg_ne_zero.mpr hderiv
    exact (mul_eq_zero.mp hmiddleScaled).resolve_left hleft
  have h13 : H13 = 0 := by
    have hleft : -2*(x.c01 + 2*x.c02*r) ≠ 0 :=
      mul_ne_zero (by norm_num) hderiv
    exact (mul_eq_zero.mp h13scaled).resolve_left hleft
  have h23 : H23 = 0 := by
    have hleft : -(x.c01 + 2*x.c02*r) ≠ 0 := neg_ne_zero.mpr hderiv
    exact (mul_eq_zero.mp h23scaled).resolve_left hleft
  have htop := ParallelLinesNoGo.cubic_constant_wronskian
    p0 p1 p2 p3 q0 q1 q2 q3 hdet h02 hmiddle h13 h23
  simpa [p2, p3, q2, q3] using htop

end TFamily

section EndToEnd

variable [IsAlgClosed K]

/-- End-to-end exclusion of the pure `v`-quadratic family from the literal
raw system, with distinct roots replacing all Wronskian/vanishing assumptions. -/
theorem parallel_v_from_raw_distinct_roots
    (x : Coefficients K) (h : RawSystem (pureV x))
    (hc20ne : x.c20 ≠ 0) (r1 r2 : K) (hr : r1 ≠ r2)
    (hroot1 : 1 + x.c10*r1 + x.c20*r1^2 = 0)
    (hroot2 : 1 + x.c10*r2 + x.c20*r2^2 = 0) : False := by
  obtain ⟨hderiv1, hderiv2⟩ := quadratic_derivatives_ne_zero
    x.c10 x.c20 r1 r2 hc20ne hr hroot1 hroot2
  obtain ⟨ha1, hb1⟩ := v_root_top_coefficients x h r1 hroot1 hderiv1
  obtain ⟨ha2, hb2⟩ := v_root_top_coefficients x h r2 hroot2 hderiv2
  obtain ⟨ha02, ha12, hb02, hb12⟩ :=
    ParallelLinesNoGo.parallel_v_two_root_vanishing
      x.a02 x.a12 x.b02 x.b12 r1 r2 hr ha1 ha2 hb1 hb2
  exact DiagonalReduction.parallel_v_from_raw (pureV x) h
    (by simpa [pureV] using hc20ne)
    (by simpa [pureV] using ha02) (by simpa [pureV] using ha12)
    (by simpa [pureV] using hb02) (by simpa [pureV] using hb12)
    (by simp [pureV]) (by simp [pureV]) (by simp [pureV])

/-- End-to-end exclusion of the pure `t`-quadratic family from the literal
raw system, with distinct roots replacing all Wronskian/vanishing assumptions. -/
theorem parallel_t_from_raw_distinct_roots
    (x : Coefficients K) (h : RawSystem (pureT x))
    (hc02ne : x.c02 ≠ 0) (r1 r2 : K) (hr : r1 ≠ r2)
    (hroot1 : 1 + x.c01*r1 + x.c02*r1^2 = 0)
    (hroot2 : 1 + x.c01*r2 + x.c02*r2^2 = 0) : False := by
  obtain ⟨hderiv1, hderiv2⟩ := quadratic_derivatives_ne_zero
    x.c01 x.c02 r1 r2 hc02ne hr hroot1 hroot2
  obtain ⟨ha1, ha30, hb1, hb30⟩ :=
    t_root_top_coefficients x h r1 hroot1 hderiv1
  obtain ⟨ha2, _, hb2, _⟩ :=
    t_root_top_coefficients x h r2 hroot2 hderiv2
  obtain ⟨ha20, ha21⟩ := ParallelLinesNoGo.affine_eq_zero_of_two_roots
    x.a20 x.a21 r1 r2 hr ha1 ha2
  obtain ⟨hb20, hb21⟩ := ParallelLinesNoGo.affine_eq_zero_of_two_roots
    x.b20 x.b21 r1 r2 hr hb1 hb2
  exact DiagonalReduction.parallel_t_from_raw (pureT x) h
    (by simpa [pureT] using hc02ne)
    (by simpa [pureT] using ha20) (by simpa [pureT] using ha21)
    (by simpa [pureT] using ha30)
    (by simpa [pureT] using hb20) (by simpa [pureT] using hb21)
    (by simpa [pureT] using hb30)
    (by simp [pureT]) (by simp [pureT]) (by simp [pureT])

end EndToEnd

#print axioms quadratic_derivatives_ne_zero
#print axioms v_root_top_coefficients
#print axioms t_root_top_coefficients
#print axioms parallel_v_from_raw_distinct_roots
#print axioms parallel_t_from_raw_distinct_roots

end WronskianDischarge
