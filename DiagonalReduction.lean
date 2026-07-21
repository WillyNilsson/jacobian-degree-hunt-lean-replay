import ParallelLinesNoGo

/-!
# End-to-end coefficient bridge for the two parallel-line families

`RawSystem` is the literal list of all 25 nonconstant coefficients of
`Delta - 1` for the normalized degree-five ansatz with `a03 = b03 = 0`.
The five lowest equations are retained: the 20-equation system used by the
search is obtained by solving those five equations.  Thus the reductions
below do not trust the search program's triangular preprocessing.
-/

namespace DiagonalReduction

variable {K : Type*} [Field K] [CharZero K]

structure Coefficients (K : Type*) where
  a20 : K
  a11 : K
  a02 : K
  a30 : K
  a21 : K
  a12 : K
  b20 : K
  b11 : K
  b02 : K
  b30 : K
  b21 : K
  b12 : K
  c10 : K
  c01 : K
  c20 : K
  c11 : K
  c02 : K

/-- The literal coefficient equations of `Delta = 1`. -/
structure RawSystem (x : Coefficients K) : Prop where
  e01 : x.a11 + 2*x.b02 + 2*x.c01 = 0
  e10 : 2*x.a20 + x.b11 + 2*x.c10 = 0
  e02 : -2*x.a02*x.b11 - x.a02*x.c10 + 2*x.a11*x.b02 + 2*x.a11*x.c01 + x.a12 + 3*x.b02*x.c01 + 3*x.c02 = 0
  e11 : -4*x.a02*x.b20 + x.a11*x.c10 + 4*x.a20*x.b02 + 4*x.a20*x.c01 + 2*x.a21 + 4*x.b02*x.c10 + x.b11*x.c01 + 2*x.b12 + 3*x.c11 = 0
  e20 : -2*x.a11*x.b20 + 2*x.a20*x.b11 + 3*x.a20*x.c10 + 3*x.a30 + 2*x.b11*x.c10 - x.b20*x.c01 + x.b21 + 3*x.c20 = 0
  e03 : -3*x.a02*x.b11*x.c01 - 2*x.a02*x.b12 - x.a02*x.c11 + 3*x.a11*x.b02*x.c01 + 3*x.a11*x.c02 + 2*x.a12*x.b02 + 2*x.a12*x.c01 + 4*x.b02*x.c02 = 0
  e12 : -3*x.a02*x.b11*x.c10 - 6*x.a02*x.b20*x.c01 - 4*x.a02*x.b21 - 2*x.a02*x.c20 + 3*x.a11*x.b02*x.c10 + x.a11*x.b12 + 2*x.a11*x.c11 - x.a12*x.b11 + 6*x.a20*x.b02*x.c01 + 6*x.a20*x.c02 + 4*x.a21*x.b02 + 4*x.a21*x.c01 + 5*x.b02*x.c11 + x.b11*x.c02 + 2*x.b12*x.c01 = 0
  e21 : -6*x.a02*x.b20*x.c10 - 6*x.a02*x.b30 - 3*x.a11*x.b20*x.c01 - x.a11*x.b21 + x.a11*x.c20 - 4*x.a12*x.b20 + 6*x.a20*x.b02*x.c10 + 3*x.a20*x.b11*x.c01 + 4*x.a20*x.b12 + 5*x.a20*x.c11 + x.a21*x.b11 + 2*x.a21*x.c10 + 6*x.a30*x.b02 + 6*x.a30*x.c01 + 6*x.b02*x.c20 + 2*x.b11*x.c11 + 4*x.b12*x.c10 - 2*x.b20*x.c02 = 0
  e30 : -3*x.a11*x.b20*x.c10 - 3*x.a11*x.b30 + 3*x.a20*x.b11*x.c10 + 2*x.a20*x.b21 + 4*x.a20*x.c20 - 2*x.a21*x.b20 + 3*x.a30*x.b11 + 4*x.a30*x.c10 + 3*x.b11*x.c20 - x.b20*x.c11 + 2*x.b21*x.c10 - 2*x.b30*x.c01 = 0
  e04 : -4*x.a02*x.b11*x.c02 - 3*x.a02*x.b12*x.c01 + 4*x.a11*x.b02*x.c02 + 3*x.a12*x.b02*x.c01 + 3*x.a12*x.c02 = 0
  e13 : -4*x.a02*x.b11*x.c11 - 2*x.a02*x.b12*x.c10 - 8*x.a02*x.b20*x.c02 - 6*x.a02*x.b21*x.c01 + 4*x.a11*x.b02*x.c11 + x.a11*x.b12*x.c01 + 2*x.a12*x.b02*x.c10 - x.a12*x.b11*x.c01 + x.a12*x.c11 + 8*x.a20*x.b02*x.c02 + 6*x.a21*x.b02*x.c01 + 6*x.a21*x.c02 + 2*x.b12*x.c02 = 0
  e22 : -4*x.a02*x.b11*x.c20 - 8*x.a02*x.b20*x.c11 - 5*x.a02*x.b21*x.c10 - 9*x.a02*x.b30*x.c01 + 4*x.a11*x.b02*x.c20 + 2*x.a11*x.b12*x.c10 - 4*x.a11*x.b20*x.c02 - 2*x.a11*x.b21*x.c01 - 2*x.a12*x.b11*x.c10 - 5*x.a12*x.b20*x.c01 - 3*x.a12*x.b21 - x.a12*x.c20 + 8*x.a20*x.b02*x.c11 + 4*x.a20*x.b11*x.c02 + 5*x.a20*x.b12*x.c01 + 5*x.a21*x.b02*x.c10 + 2*x.a21*x.b11*x.c01 + 3*x.a21*x.b12 + 4*x.a21*x.c11 + 9*x.a30*x.b02*x.c01 + 9*x.a30*x.c02 + 4*x.b12*x.c11 - x.b21*x.c02 = 0
  e31 : -8*x.a02*x.b20*x.c20 - 8*x.a02*x.b30*x.c10 - 4*x.a11*x.b20*x.c11 - x.a11*x.b21*x.c10 - 5*x.a11*x.b30*x.c01 - 6*x.a12*x.b20*x.c10 - 6*x.a12*x.b30 + 8*x.a20*x.b02*x.c20 + 4*x.a20*x.b11*x.c11 + 6*x.a20*x.b12*x.c10 + 2*x.a20*x.b21*x.c01 + x.a21*x.b11*x.c10 - 2*x.a21*x.b20*x.c01 + 2*x.a21*x.c20 + 8*x.a30*x.b02*x.c10 + 5*x.a30*x.b11*x.c01 + 6*x.a30*x.b12 + 7*x.a30*x.c11 + 6*x.b12*x.c20 + x.b21*x.c11 - 4*x.b30*x.c02 = 0
  e40 : -4*x.a11*x.b20*x.c20 - 4*x.a11*x.b30*x.c10 + 4*x.a20*x.b11*x.c20 + 3*x.a20*x.b21*x.c10 - x.a20*x.b30*x.c01 - 3*x.a21*x.b20*x.c10 - 3*x.a21*x.b30 + 4*x.a30*x.b11*x.c10 + x.a30*x.b20*x.c01 + 3*x.a30*x.b21 + 5*x.a30*x.c20 + 3*x.b21*x.c20 - 2*x.b30*x.c11 = 0
  e05 : -4*x.a02*x.b12*x.c02 + 4*x.a12*x.b02*x.c02 = 0
  e14 : -3*x.a02*x.b12*x.c11 - 8*x.a02*x.b21*x.c02 + x.a11*x.b12*x.c02 + 3*x.a12*x.b02*x.c11 - x.a12*x.b11*x.c02 + 8*x.a21*x.b02*x.c02 = 0
  e23 : -2*x.a02*x.b12*x.c20 - 7*x.a02*x.b21*x.c11 - 12*x.a02*x.b30*x.c02 + 2*x.a11*x.b12*x.c11 - 3*x.a11*x.b21*x.c02 + 2*x.a12*x.b02*x.c20 - 2*x.a12*x.b11*x.c11 - 6*x.a12*x.b20*x.c02 - 4*x.a12*x.b21*x.c01 + 6*x.a20*x.b12*x.c02 + 7*x.a21*x.b02*x.c11 + 3*x.a21*x.b11*x.c02 + 4*x.a21*x.b12*x.c01 + 12*x.a30*x.b02*x.c02 = 0
  e32 : -6*x.a02*x.b21*x.c20 - 11*x.a02*x.b30*x.c11 + 3*x.a11*x.b12*x.c20 - 2*x.a11*x.b21*x.c11 - 7*x.a11*x.b30*x.c02 - 3*x.a12*x.b11*x.c20 - 7*x.a12*x.b20*x.c11 - 4*x.a12*x.b21*x.c10 - 8*x.a12*x.b30*x.c01 + 7*x.a20*x.b12*x.c11 + 2*x.a20*x.b21*x.c02 + 6*x.a21*x.b02*x.c20 + 2*x.a21*x.b11*x.c11 + 4*x.a21*x.b12*x.c10 - 2*x.a21*x.b20*x.c02 + 11*x.a30*x.b02*x.c11 + 7*x.a30*x.b11*x.c02 + 8*x.a30*x.b12*x.c01 = 0
  e41 : -10*x.a02*x.b30*x.c20 - x.a11*x.b21*x.c20 - 6*x.a11*x.b30*x.c11 - 8*x.a12*x.b20*x.c20 - 8*x.a12*x.b30*x.c10 + 8*x.a20*x.b12*x.c20 + 3*x.a20*x.b21*x.c11 - 2*x.a20*x.b30*x.c02 + x.a21*x.b11*x.c20 - 3*x.a21*x.b20*x.c11 - 4*x.a21*x.b30*x.c01 + 10*x.a30*x.b02*x.c20 + 6*x.a30*x.b11*x.c11 + 8*x.a30*x.b12*x.c10 + 2*x.a30*x.b20*x.c02 + 4*x.a30*x.b21*x.c01 = 0
  e50 : -5*x.a11*x.b30*x.c20 + 4*x.a20*x.b21*x.c20 - x.a20*x.b30*x.c11 - 4*x.a21*x.b20*x.c20 - 4*x.a21*x.b30*x.c10 + 5*x.a30*x.b11*x.c20 + x.a30*x.b20*x.c11 + 4*x.a30*x.b21*x.c10 = 0
  e24 : -5*x.a12*x.b21*x.c02 + 5*x.a21*x.b12*x.c02 = 0
  e33 : -5*x.a12*x.b21*x.c11 - 10*x.a12*x.b30*x.c02 + 5*x.a21*x.b12*x.c11 + 10*x.a30*x.b12*x.c02 = 0
  e42 : -5*x.a12*x.b21*x.c20 - 10*x.a12*x.b30*x.c11 + 5*x.a21*x.b12*x.c20 - 5*x.a21*x.b30*x.c02 + 10*x.a30*x.b12*x.c11 + 5*x.a30*x.b21*x.c02 = 0
  e51 : -10*x.a12*x.b30*x.c20 - 5*x.a21*x.b30*x.c11 + 10*x.a30*x.b12*x.c20 + 5*x.a30*x.b21*x.c11 = 0
  e60 : -5*x.a21*x.b30*x.c20 + 5*x.a30*x.b21*x.c20 = 0

/-- Coefficient action induced by `(v,t) = (lambda*v',lambda^-1*t')`
and `(alpha,beta) = (lambda^-1*alpha,lambda*beta)`. -/
def diagonal (lambda : K) (x : Coefficients K) : Coefficients K where
  a20 := lambda*x.a20
  a11 := x.a11/lambda
  a02 := x.a02/lambda^3
  a30 := lambda^2*x.a30
  a21 := x.a21
  a12 := x.a12/lambda^2
  b20 := lambda^3*x.b20
  b11 := lambda*x.b11
  b02 := x.b02/lambda
  b30 := lambda^4*x.b30
  b21 := lambda^2*x.b21
  b12 := x.b12
  c10 := lambda*x.c10
  c01 := x.c01/lambda
  c20 := lambda^2*x.c20
  c11 := x.c11
  c02 := x.c02/lambda^2

local macro "covariance" f:term h:term : tactic =>
  `(tactic| (convert congrArg ($f) ($h) using 1 <;>
    simp [diagonal] <;> field_simp <;> ring))

/-- Every literal coefficient equation transforms with weight `lambda^(i-j)`. -/
theorem diagonal_preserves_raw_system
    (lambda : K) (hLambda : Ne lambda 0) (x : Coefficients K)
    (h : RawSystem x) : RawSystem (diagonal lambda x) := by
  refine {
    e01 := ?_, e10 := ?_, e02 := ?_, e11 := ?_, e20 := ?_,
    e03 := ?_, e12 := ?_, e21 := ?_, e30 := ?_, e04 := ?_,
    e13 := ?_, e22 := ?_, e31 := ?_, e40 := ?_, e05 := ?_,
    e14 := ?_, e23 := ?_, e32 := ?_, e41 := ?_, e50 := ?_,
    e24 := ?_, e33 := ?_, e42 := ?_, e51 := ?_, e60 := ?_ }
  case refine_1 => covariance (fun z : K => z/lambda) h.e01
  case refine_2 => covariance (fun z : K => lambda*z) h.e10
  case refine_3 => covariance (fun z : K => z/lambda^2) h.e02
  case refine_4 => covariance (fun z : K => z) h.e11
  case refine_5 => covariance (fun z : K => lambda^2*z) h.e20
  case refine_6 => covariance (fun z : K => z/lambda^3) h.e03
  case refine_7 => covariance (fun z : K => z/lambda) h.e12
  case refine_8 => covariance (fun z : K => lambda*z) h.e21
  case refine_9 => covariance (fun z : K => lambda^3*z) h.e30
  case refine_10 => covariance (fun z : K => z/lambda^4) h.e04
  case refine_11 => covariance (fun z : K => z/lambda^2) h.e13
  case refine_12 => covariance (fun z : K => z) h.e22
  case refine_13 => covariance (fun z : K => lambda^2*z) h.e31
  case refine_14 => covariance (fun z : K => lambda^4*z) h.e40
  case refine_15 => covariance (fun z : K => z/lambda^5) h.e05
  case refine_16 => covariance (fun z : K => z/lambda^3) h.e14
  case refine_17 => covariance (fun z : K => z/lambda) h.e23
  case refine_18 => covariance (fun z : K => lambda*z) h.e32
  case refine_19 => covariance (fun z : K => lambda^3*z) h.e41
  case refine_20 => covariance (fun z : K => lambda^5*z) h.e50
  case refine_21 => covariance (fun z : K => z/lambda^2) h.e24
  case refine_22 => covariance (fun z : K => z) h.e33
  case refine_23 => covariance (fun z : K => lambda^2*z) h.e42
  case refine_24 => covariance (fun z : K => lambda^4*z) h.e51
  case refine_25 => covariance (fun z : K => lambda^6*z) h.e60

/-- The four `v`-family certificate inputs are consequences of the literal
coefficient system, including its five triangular equations. -/
theorem normalized_parallel_v_from_raw
    (x : Coefficients K) (h : RawSystem x)
    (ha02 : x.a02 = 0) (ha12 : x.a12 = 0)
    (hb02 : x.b02 = 0) (hb12 : x.b12 = 0)
    (hc01 : x.c01 = 0) (hc20 : x.c20 = 1)
    (hc11 : x.c11 = 0) (hc02 : x.c02 = 0) : False := by
  have ha11 : x.a11 = 0 := by
    linear_combination h.e01
  have ha20 : x.a20 = -(x.b11 + 2*x.c10)/2 := by
    linear_combination (1/2) * h.e10
  have ha21 : x.a21 = 0 := by
    have hx := h.e11
    rw [ha02, ha11, ha20, hb02, hb12, hc01, hc11] at hx
    linear_combination (1/2) * hx
  have ha30 : x.a30 =
      (2*x.b11^2 + 3*x.b11*x.c10 - 2*x.b21 +
        6*x.c10^2 - 6)/6 := by
    have hx := h.e20
    rw [ha11, ha20, hc01, hc20] at hx
    linear_combination (1/3) * hx
  have e1 : 10*x.b11^2*x.b21 + 15*x.b11*x.b21*x.c10
      - 10*x.b21^2 + 30*x.b21*x.c10^2 - 30*x.b21 = 0 := by
    have hx := h.e60
    rw [ha21, ha30, hc20] at hx
    linear_combination 6 * hx
  have e2 : 10*x.b11^3 + 8*x.b11^2*x.b21*x.c10
      + 15*x.b11^2*x.c10 + 12*x.b11*x.b21*x.c10^2
      - 22*x.b11*x.b21 + 30*x.b11*x.c10^2 - 30*x.b11
      - 8*x.b21^2*x.c10 + 24*x.b21*x.c10^3
      - 48*x.b21*x.c10 = 0 := by
    have hx := h.e50
    rw [ha11, ha20, ha21, ha30, hc01, hc20, hc11] at hx
    linear_combination 6 * hx
  have e3 : 8*x.b11^3*x.c10 + 6*x.b11^2*x.b21
      + 12*x.b11^2*x.c10^2 - 2*x.b11^2
      - 8*x.b11*x.b21*x.c10 + 24*x.b11*x.c10^3
      - 33*x.b11*x.c10 - 6*x.b21^2 - 10*x.b21
      + 30*x.c10^2 - 30 = 0 := by
    have hx := h.e40
    rw [ha11, ha20, ha21, ha30, hb12, hc01, hc20, hc11] at hx
    linear_combination 6 * hx
  have e4 : 6*x.b11^3 + 8*x.b11^2*x.c10 - 12*x.b11*x.b21
      + 12*x.b11*x.c10^2 - 12*x.b11 - 8*x.b21*x.c10
      + 24*x.c10^3 - 48*x.c10 = 0 := by
    have hx := h.e30
    rw [ha11, ha20, ha21, ha30, hc01, hc20, hc11] at hx
    linear_combination 6 * hx
  exact ParallelLinesNoGo.normalized_parallel_v_certificate
    x.b11 x.b21 x.c10 e1 e2 e3 e4

/-- The two triangular equations and three `t`-family certificate inputs are
consequences of the literal coefficient system. -/
theorem normalized_parallel_t_from_raw
    (x : Coefficients K) (h : RawSystem x)
    (ha20 : x.a20 = 0) (ha21 : x.a21 = 0) (ha30 : x.a30 = 0)
    (hb20 : x.b20 = 0) (hb21 : x.b21 = 0) (hb30 : x.b30 = 0)
    (hc10 : x.c10 = 0) (hc20 : x.c20 = 0)
    (hc11 : x.c11 = 0) (hc02 : x.c02 = 1) : False := by
  have hb11 : x.b11 = 0 := by
    have hx := h.e10
    rw [ha20, hc10] at hx
    linear_combination hx
  have hb12 : x.b12 = 0 := by
    have hx := h.e11
    rw [ha20, ha21, hb20, hb11, hc10, hc11] at hx
    linear_combination (1/2) * hx
  have ha11 : x.a11 = -2*(x.b02 + x.c01) := by
    linear_combination h.e01
  have ha12 : x.a12 =
      4*x.b02^2 + 5*x.b02*x.c01 + 4*x.c01^2 - 3 := by
    have hx := h.e02
    rw [hb11, ha11, hc10, hc02] at hx
    linear_combination hx
  have e1 : 16*x.b02^3 + 20*x.b02^2*x.c01
      + 16*x.b02*x.c01^2 - 12*x.b02 = 0 := by
    have hx := h.e05
    rw [hb12, ha12, hc02] at hx
    linear_combination hx
  have e2 : 12*x.b02^3*x.c01 + 15*x.b02^2*x.c01^2
      + 4*x.b02^2 + 12*x.b02*x.c01^3 - 2*x.b02*x.c01
      + 12*x.c01^2 - 9 = 0 := by
    have hx := h.e04
    rw [hb11, hb12, ha11, ha12, hc02] at hx
    linear_combination hx
  have e3 : 8*x.b02^3 + 12*x.b02^2*x.c01
      + 12*x.b02*x.c01^2 - 8*x.b02
      + 8*x.c01^3 - 12*x.c01 = 0 := by
    have hx := h.e03
    rw [hb11, hb12, ha11, ha12, hc11, hc02] at hx
    linear_combination hx
  exact ParallelLinesNoGo.normalized_parallel_t_certificate
    x.b02 x.c01 e1 e2 e3

/-- End-to-end `v`-family theorem from the literal system through the
determinant-one diagonal normalization to the checked certificate. -/
theorem parallel_v_from_raw_after_diagonal
    (x : Coefficients K) (h : RawSystem x)
    (lambda : K) (hLambda : Ne lambda 0)
    (hScale : lambda^2*x.c20 = 1)
    (ha02 : x.a02 = 0) (ha12 : x.a12 = 0)
    (hb02 : x.b02 = 0) (hb12 : x.b12 = 0)
    (hc01 : x.c01 = 0) (hc11 : x.c11 = 0) (hc02 : x.c02 = 0) : False := by
  let y := diagonal lambda x
  have hy : RawSystem y := diagonal_preserves_raw_system lambda hLambda x h
  apply normalized_parallel_v_from_raw y hy
  all_goals simp [y, diagonal, ha02, ha12, hb02, hb12,
    hc01, hc11, hc02, hScale]

/-- End-to-end `t`-family theorem from the literal system through the
determinant-one diagonal normalization to the checked certificate. -/
theorem parallel_t_from_raw_after_diagonal
    (x : Coefficients K) (h : RawSystem x)
    (lambda : K) (hLambda : Ne lambda 0)
    (hScale : x.c02 = lambda^2)
    (ha20 : x.a20 = 0) (ha21 : x.a21 = 0) (ha30 : x.a30 = 0)
    (hb20 : x.b20 = 0) (hb21 : x.b21 = 0) (hb30 : x.b30 = 0)
    (hc10 : x.c10 = 0) (hc20 : x.c20 = 0) (hc11 : x.c11 = 0) : False := by
  let y := diagonal lambda x
  have hy : RawSystem y := diagonal_preserves_raw_system lambda hLambda x h
  apply normalized_parallel_t_from_raw y hy
  all_goals simp [y, diagonal, ha20, ha21, ha30, hb20, hb21, hb30,
    hc10, hc20, hc11, hScale, hLambda]

section AlgebraicallyClosed

variable [IsAlgClosed K]

/-- Over an algebraically closed field the required `v`-normalizing scale
exists whenever the pure quadratic coefficient is nonzero. -/
theorem parallel_v_from_raw
    (x : Coefficients K) (h : RawSystem x) (hc20ne : Ne x.c20 0)
    (ha02 : x.a02 = 0) (ha12 : x.a12 = 0)
    (hb02 : x.b02 = 0) (hb12 : x.b12 = 0)
    (hc01 : x.c01 = 0) (hc11 : x.c11 = 0) (hc02 : x.c02 = 0) : False := by
  choose lambda hPow using
    IsAlgClosed.exists_pow_nat_eq (Inv.inv x.c20) (by norm_num : 0 < 2)
  have hLambda : Ne lambda 0 := by
    intro hz
    rw [hz] at hPow
    norm_num at hPow
    exact hc20ne hPow.symm
  have hScale : lambda^2*x.c20 = 1 := by
    rw [hPow]
    field_simp
  exact parallel_v_from_raw_after_diagonal x h lambda hLambda hScale
    ha02 ha12 hb02 hb12 hc01 hc11 hc02

/-- Over an algebraically closed field the required `t`-normalizing scale
exists whenever the pure quadratic coefficient is nonzero. -/
theorem parallel_t_from_raw
    (x : Coefficients K) (h : RawSystem x) (hc02ne : Ne x.c02 0)
    (ha20 : x.a20 = 0) (ha21 : x.a21 = 0) (ha30 : x.a30 = 0)
    (hb20 : x.b20 = 0) (hb21 : x.b21 = 0) (hb30 : x.b30 = 0)
    (hc10 : x.c10 = 0) (hc20 : x.c20 = 0) (hc11 : x.c11 = 0) : False := by
  choose lambda hPow using
    IsAlgClosed.exists_pow_nat_eq x.c02 (by norm_num : 0 < 2)
  have hLambda : Ne lambda 0 := by
    intro hz
    rw [hz] at hPow
    norm_num at hPow
    exact hc02ne hPow.symm
  exact parallel_t_from_raw_after_diagonal x h lambda hLambda hPow.symm
    ha20 ha21 ha30 hb20 hb21 hb30 hc10 hc20 hc11

end AlgebraicallyClosed

#print axioms diagonal_preserves_raw_system
#print axioms normalized_parallel_v_from_raw
#print axioms normalized_parallel_t_from_raw
#print axioms parallel_v_from_raw_after_diagonal
#print axioms parallel_t_from_raw_after_diagonal
#print axioms parallel_v_from_raw
#print axioms parallel_t_from_raw

end DiagonalReduction
