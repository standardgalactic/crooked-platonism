import Mathlib

/-!
# ConstantJerk

Status: theorem.

Scope: a smooth function whose third derivative is identically 1 exists. So the
constant-jerk conclusion of the self-inversion argument comes from the equation
and the continuity step, and `x = t^3/6` is a concrete trajectory it applies to.
-/

namespace CrookedPlatonism.ConstantJerk

theorem iteratedDeriv_cubic :
    iteratedDeriv 3 (fun t : ℝ => t ^ 3 / 6) = fun _ => 1 := by
  have h1 : deriv (fun t : ℝ => t ^ 3 / 6) = fun t => t ^ 2 / 2 := by
    funext t
    have h := (hasDerivAt_pow 3 t).div_const 6
    refine h.deriv.trans ?_
    norm_num
    ring
  have h2 : deriv (fun t : ℝ => t ^ 2 / 2) = fun t => t := by
    funext t
    have h := (hasDerivAt_pow 2 t).div_const 2
    refine h.deriv.trans ?_
    norm_num
  have h3 : deriv (fun t : ℝ => t) = fun _ => (1 : ℝ) := by
    funext t
    exact (hasDerivAt_id t).deriv
  rw [iteratedDeriv_succ, iteratedDeriv_succ, iteratedDeriv_one, h1, h2, h3]

#print axioms iteratedDeriv_cubic

end CrookedPlatonism.ConstantJerk
