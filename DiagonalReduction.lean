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
  a20 a11 a02 a30 a21 a12 : K
  b20 b11 b02 b30 b21 b12 : K
  c10 c01 c20 c11 c02 : K

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
  `(tactic| (convert congrArg $f $h using 1 <;>
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
  case e01 => covariance (fun z : K => z/lambda) h.e01
  case e10 => covariance (fun z : K => lambda*z) h.e10
  case e02 => covariance (fun z : K => z/lambda^2) h.e02
  case e11 => covariance (fun z : K => z) h.e11
  case e20 => covariance (fun z : K => lambda^2*z) h.e20
  case e03 => covariance (fun z : K => z/lambda^3) h.e03
  case e12 => covariance (fun z : K => z/lambda) h.e12
  case e21 => covariance (fun z : K => lambda*z) h.e21
  case e30 => covariance (fun z : K => lambda^3*z) h.e30
  case e04 => covariance (fun z : K => z/lambda^4) h.e04
  case e13 => covariance (fun z : K => z/lambda^2) h.e13
  case e22 => covariance (fun z : K => z) h.e22
  case e31 => covariance (fun z : K => lambda^2*z) h.e31
  case e40 => covariance (fun z : K => lambda^4*z) h.e40
  case e05 => covariance (fun z : K => z/lambda^5) h.e05
  case e14 => covariance (fun z : K => z/lambda^3) h.e14
  case e23 => covariance (fun z : K => z/lambda) h.e23
  case e32 => covariance (fun z : K => lambda*z) h.e32
  case e41 => covariance (fun z : K => lambda^3*z) h.e41
  case e50 => covariance (fun z : K => lambda^5*z) h.e50
  case e24 => covariance (fun z : K => z/lambda^2) h.e24
  case e33 => covariance (fun z : K => z) h.e33
  case e42 => covariance (fun z : K => lambda^2*z) h.e42
  case e51 => covariance (fun z : K => lambda^4*z) h.e51
  case e60 => covariance (fun z : K => lambda^6*z) h.e60

end DiagonalReduction

