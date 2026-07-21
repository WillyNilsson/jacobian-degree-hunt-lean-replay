# Missing components, supplied: GL₂ witnesses, bridge derivations, and a certificate proof of the constant-γ endpoint

*July 21, 2026, originating Claude (Fable) session. Response to the formalization-audit table. Machine checks: `gl2_witnesses.py`, `endpoint_certificates.py` (+ background exact run, see status). Evidence labels as before.*

## 1. GL₂ covariance — full proof and machine check [proof + CAS]

**Lemma.** For M, N ∈ GL₂ acting by (α, β, γ) ↦ (N(α∘M, β∘M), γ∘M): Δ ↦ det(N)·det(M)·Δ∘M.

*Proof.* (i) J(f∘M, g∘M) = det(M)·J(f,g)∘M (chain rule), giving the det(M) factor and the ∘M on every term. (ii) For the N-action write E(a,b) := b·J(a,γ) − a·J(b,γ); expanding E(n₁₁a+n₁₂b, n₂₁a+n₂₂b) the diagonal terms a·J(a,γ), b·J(b,γ) cancel and the cross terms collect to det(N)·E(a,b); the first term γ·J(a,b) is det(N)-homogeneous by (i)'s algebra. Δ = γJ(α,β) + E(α,β). ∎ Machine-checked with fully symbolic coefficient polynomials and exact rational M, N. (An earlier abstract-function check returned a false negative — a SymPy `Derivative`-substitution artifact, not mathematics; noted for the record.)

## 2. Conic classification with explicit witnesses [proof + CAS]

Let q = c₂₀v² + c₁₁vt + c₀₂t² be the quadratic part, D = c₁₁² − 4c₂₀c₀₂.

- **q = 0, γ nonconstant (lines):** witness M sending ℓ = c₁₀v + c₀₁t ↦ v: M = [[c₁₀, c₀₁],[0,1]] if c₁₀ ≠ 0, else [[0, c₀₁],[1,0]]. Normal form 1 + v.
- **D ≠ 0 (nondegenerate):** if c₂₀ ≠ 0, q = c₂₀(v − r₁t)(v − r₂t) with rᵢ = (−c₁₁ ± s)/(2c₂₀), s² = D — **machine-verified factorization witness**; M maps the two linear factors to the coordinates, giving q ↦ (const)·vt; if c₂₀ = 0 ≠ c₀₂, swap v ↔ t first; if c₂₀ = c₀₂ = 0, q is already c₁₁vt. The residual torus and slot scalings then reach 1 + mv + t + vt, 1 + v + vt, or 1 + vt. Crossing-line (reducible) members are dispatched by the smoothness corollary; the symbolic-m unit ideal covers them redundantly.
- **D = 0, q ≠ 0 (degenerate):** q = c₂₀(v + c₁₁t/(2c₂₀))² (or the c₀₂-branch with roles swapped) — **machine-verified square witness**; M: ℓ ↦ v gives q ↦ (const)v². If the transformed t-coefficient c₀₁′ = 0 the conic is a parallel-line pair or line ⇒ lands in the v-only/line cases; otherwise the shear (v,t) ↦ (v, t + kv), k = −c₁₀′/c₀₁′ (which fixes v²) kills the v-linear term and scalings give **1 + t + v²**.

Every step is an explicit matrix; the case dispatch is decidable from (c₁₀, c₀₁, c₂₀, c₁₁, c₀₂) by polynomial conditions (D, c₂₀, c₀₁′, reducibility = vanishing of the 3×3 conic determinant det[[1, c₁₀/2, c₀₁/2],[c₁₀/2, c₂₀, c₁₁/2],[c₀₁/2, c₁₁/2, c₀₂]]).

## 3. Bridge derivations per canonical case [proof; systems verified CAS]

Uniform pattern, formalizable exactly like `WronskianDischarge.lean`: parametrize the contracted curve by φ(s) with φ′ = h·X_γ∘φ (X_γ = (γ_t, −γ_v)); then **W(f₁, f₂) = −h·Δ∘φ** for the restrictions fᵢ; Δ ≡ δ forces W = −δh.

| Case | φ(s) | h | Consequence chain |
|---|---|---|---|
| 1 + v | (−1, s) | −1 | cubic restrictions, span lemma ⇒ a₀₃ = b₀₃ = 0, a₀₂ = a₁₂, b₀₂ = b₁₂ ⇒ Gröbner unit [ℚ-exact] |
| 1 + t + v² | (s, −(1+s²)) | 1 | sextic restrictions, span lemma ⇒ ten vanishings ⇒ 4 unknowns ⇒ unit [ℚ-exact] |
| 1 + mv + t + vt | (s, −(1+ms)/(1+s)) | 1/(1+s) | gᵢ = (1+s)³fᵢ; W(g₁,g₂) = −δ(1+s)⁵ ⇒ 12 conditions ⇒ unit, m symbolic [ℚ-exact] |
| 1 + v + vt / 1 + vt | (s, −(1+s)/s) / (s, −1/s) | 1/s | gᵢ = s³fᵢ; W(g₁,g₂) = −δs⁵ ⇒ unit [ℚ-exact] |
| axis quadratics | two lines v = rᵢ or t = rᵢ | −1/γ′(rᵢ) | span + two-root vanishing (already the Lean-checked pattern) |

The span lemma at degree ≤ 6 and the restriction identity (linear combinations of the raw coefficient equations, weighted by powers of the root/parameter) are the only two ingredients beyond what `ParallelLinesNoGo.lean` and `WronskianDischarge.lean` already formalize.

## 4. The constant-γ endpoint — now a certificate theorem, no Moh citation [proof + CAS]

**Theorem.** A plane pair (α, β) of degree ≤ 3 with normalized jets (α = v + h.o.t., β = t + h.o.t.) and J(α, β) ≡ const ≠ 0 is injective on ℂ².

*Proof.* Suppose α, β collide at P₁ ≠ P₂. Translate P₂ to the origin (ᾱ(w) = α(w+P₂) − α(P₂); still degree ≤ 3, still Keller) and renormalize jets by D(α,β)(P₂)⁻¹ (invertible since the Jacobian is a nonzero constant; the full cubic ansatz is closed under both operations). The collision is now at (P, 0), P ≠ 0. Conjugating by the torus diag(λ, μ) (with jet compensation) scales P: **WLOG P = (1, p) or P = (0, 1)**. Each case adds two collision equations α(P) = β(P) = 0 to the 14 Keller coefficient equations, and:

- case (0,1): **unit ideal, exact over ℚ** ✓;
- case (1,p) with p symbolic: **unit ideal modulo 32003** ✓; the exact ℚ Gröbner run is in progress in the background at freeze time (deterministic script `endpoint_certificates.py`; anyone can complete it — evidence label until then: modular + one exact case). ∎

**Scaffold consequence.** γ ≡ γ₀ ≠ 0 makes Δ = γ₀J(α,β) ≡ δ, so (α,β) is such a pair; F = (α/x, β/x, γ₀x) forces equal x-coordinates at any collision (third slot), x ≠ 0 collisions reduce to pair collisions (none), and F(0,y,z) = (y, z, 0) is injective with third coordinate 0 ≠ γ₀x for x ≠ 0. So constant-γ scaffold maps are injective — **the endpoint no longer imports any external theorem**. (The statement itself is classically known within JC₂ small-degree verifications; the contribution is the self-contained certificate form, which is exactly the shape the existing Lean machinery consumes. No novelty claim.)

## 5. Updated status against the audit table

| Layer | Status now |
|---|---|
| Six certificates + 27-coefficient system | Lean-checked (Codex) |
| GL₂ covariance + classification | **proof and explicit witnesses supplied here, machine-checked** — remaining: formalization |
| Certificate-system derivations (bridges) | **uniform derivation supplied (§3)** — remaining: formalization on the existing pattern |
| Constant-γ endpoint | **self-contained certificate theorem supplied (§4)** — remaining: one exact GB completes; then formalization identical in shape to the parallel-line certificates |
| Case dispatch + final assembly | Lean wiring, unblocked once the above are formalized |

The "complete Lean formalization" phrasing in the earlier handoff was indeed too strong; with this document the missing items are, to my knowledge, all supplied at the level of proofs, witnesses, and deterministic computations — the remaining work is formalization and the one running Gröbner basis.
