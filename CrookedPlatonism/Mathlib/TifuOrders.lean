import Mathlib

/-!
# TifuOrders

Status: theorem.

Scope: the axiom `A x` says `x t ≠ 0` and `x t = 1 / x t` for all `t` (ordinary
partial reciprocal). If a function is constant, its derivative is zero, so `A`
fails for that derivative. This is the engine of the appendix result that
axioms for two different orders are jointly unsatisfiable.
-/

namespace CrookedPlatonism.TifuOrders

/-- The self-inversion axiom for a function `x`, with the nonzero clause. -/
def A (x : ℝ → ℝ) : Prop := ∀ t, x t ≠ 0 ∧ x t = 1 / x t

/-- The derivative of a constant function is the zero function. -/
theorem deriv_of_const (c : ℝ) : deriv (fun _ : ℝ => c) = fun _ => 0 := by
  funext t
  simp

/-- If `g` is constant, `A` fails for `deriv g`. -/
theorem not_A_deriv_of_const (c : ℝ) : ¬ A (deriv (fun _ : ℝ => c)) := by
  intro h
  have h0 := (h 0).1
  simp at h0

end CrookedPlatonism.TifuOrders
#print axioms CrookedPlatonism.TifuOrders.not_A_deriv_of_const
