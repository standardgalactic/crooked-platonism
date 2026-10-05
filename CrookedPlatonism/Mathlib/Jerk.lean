import Mathlib

/-!
# Jerk

Status: theorem (algebra), with the convention difference stated explicitly.

Scope: the equation `j = 1/j` is checked as algebra over the reals. Whether it
constrains physical trajectories is a separate, unsupported step.
-/

namespace CrookedPlatonism.Jerk

/-- With the ordinary partial reciprocal (so `j ≠ 0`), `j = 1/j` gives `j = ±1`. -/
theorem self_inverse_cases (j : ℝ) (h0 : j ≠ 0) (h : j = 1 / j) :
    j = 1 ∨ j = -1 := by
  have h1 : j * j = 1 := by
    calc j * j = j * (1 / j) := by rw [← h]
      _ = 1 := mul_one_div_cancel h0
  exact mul_self_eq_one_iff.mp h1

/-- Under Mathlib's total convention `1/0 = 0`, `j = 0` also satisfies `j = 1/j`.
This is why the reciprocal convention has to be stated. -/
theorem zero_satisfies_totalized : (0 : ℝ) = 1 / 0 := by simp

-- The constant-jerk conclusion needs both the nonzero clause and continuity.
-- A smooth function with third derivative identically 1 is `fun t => t ^ 3 / 6`.
-- TODO(jerk): prove `iteratedDeriv 3 (fun t : ℝ => t ^ 3 / 6) = fun _ => 1`.

end CrookedPlatonism.Jerk
#print axioms CrookedPlatonism.Jerk.self_inverse_cases
#print axioms CrookedPlatonism.Jerk.zero_satisfies_totalized
