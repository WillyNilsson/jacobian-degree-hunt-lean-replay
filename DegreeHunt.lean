import Std

/-!
# Kernel-checked algebraic certificates for the degree hunt

This file contains no proof placeholders and imports only Lean's standard library.  The
variables stand for arbitrary polynomial values and first derivatives.  Since
the identities are polynomial identities with integer coefficients, checking
them over `Int` certifies the universal formal algebra used in the note.

The companion `DegreeHuntMathlib.lean` formalizes the Wronskian and polynomial
degree arguments and proves the complete coefficient-level no-go theorem.
This smaller file independently checks the raw determinant and expansion
identities while importing only Lean's standard library.
-/

namespace DegreeHunt

def bracketJet (pv pt qv qt : Int) : Int :=
  pv * qt - pt * qv

def deltaJet
    (a av atv b bv bt g gv gt : Int) : Int :=
  g * bracketJet av atv bv bt
    + b * bracketJet av atv gv gt
    + a * bracketJet gv gt bv bt

def det3
    (a11 a12 a13 a21 a22 a23 a31 a32 a33 : Int) : Int :=
  a11 * (a22 * a33 - a23 * a32)
    - a12 * (a21 * a33 - a23 * a31)
    + a13 * (a21 * a32 - a22 * a31)

/-- The generic chain-rule determinant in Lemma 1. -/
theorem lemma1_generic_determinant
    (a av atv b bv bt g gv gt : Int) :
    det3 (-a) av atv (-b) bv bt g gv gt =
      deltaJet a av atv b bv bt g gv gt := by
  simp [det3, deltaJet, bracketJet]
  grind

/-- The product-rule identity `det D(gamma*alpha,gamma*beta)=gamma*Delta`. -/
theorem lemma2_product_identity
    (a av atv b bv bt g gv gt : Int) :
    (gv * a + g * av) * (gt * b + g * bt)
        - (gt * a + g * atv) * (gv * b + g * bv)
      = g * deltaJet a av atv b bv bt g gv gt := by
  simp [deltaJet, bracketJet]
  grind

def e0
    (a av A b bv B g gv G : Int) : Int :=
  g * (av * B - A * bv)
    + b * (av * G - A * gv)
    + a * (gv * B - G * bv)

def e1
    (a av A Av b bv B Bv g gv G Gv : Int) : Int :=
  g * (Av * B - A * Bv)
    + G * (av * B - A * bv)
    + B * (av * G - A * gv)
    + b * (Av * G - A * Gv)
    + a * (Gv * B - G * Bv)
    + A * (gv * B - G * bv)

def e2 (A Av B Bv G : Int) : Int :=
  2 * G * (Av * B - A * Bv)

/-- Complete expansion when alpha, beta and gamma are linear in `t`. -/
theorem t_linear_complete_expansion
    (t a av A Av b bv B Bv g gv G Gv : Int) :
    deltaJet
        (a + t * A) (av + t * Av) A
        (b + t * B) (bv + t * Bv) B
        (g + t * G) (gv + t * Gv) G
      = e0 a av A b bv B g gv G
        + t * e1 a av A Av b bv B Bv g gv G Gv
        + t^2 * e2 A Av B Bv G := by
  simp [deltaJet, bracketJet, e0, e1, e2]
  grind

/-- The disputed terms cancel when `G=0`. -/
theorem g_zero_cancellation
    (A Av B Bv g gv : Int) :
    g * (Av * B - A * Bv) - B * A * gv + A * gv * B
      = g * (Av * B - A * Bv) := by
  grind

/-- With `A=G=0`, Delta collapses to `B*(g*a)'`. -/
theorem aG_zero_collapse
    (a av B g gv : Int) :
    g * av * B + a * gv * B = B * (g * av + gv * a) := by
  grind

/-- With `A=0`, the linear coefficient has the displayed form. -/
theorem a_zero_linear_coefficient
    (a av B Bv G Gv : Int) :
    G * av * B + B * av * G + a * (Gv * B - G * Bv)
      = 2 * av * B * G + a * (Gv * B - G * Bv) := by
  grind

/-- The two lowest-order contradictions used in the `G != 0` case. -/
theorem characteristic_zero_lowest_coefficients
    (G0 G1 : Int)
    (constantCoefficient : 2 * G0 = 0)
    (nextCoefficient : 3 * G1 = 0) :
    G0 = 0 ∧ G1 = 0 := by
  omega

end DegreeHunt

#print axioms DegreeHunt.lemma1_generic_determinant
#print axioms DegreeHunt.lemma2_product_identity
#print axioms DegreeHunt.t_linear_complete_expansion
#print axioms DegreeHunt.g_zero_cancellation
#print axioms DegreeHunt.characteristic_zero_lowest_coefficients
