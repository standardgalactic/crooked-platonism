/-
This file illustrates how Lean treats jerk (the third derivative)
as ontologically non-fundamental.
-/

-- In Lean, jerk is just another higher-order derivative:
def jerk (x : ℝ → ℝ) : ℝ → ℝ :=
  deriv (deriv (deriv x))

/-
TONE claims that jerk is the highest ontologically admissible
form of change. Everything above jerk leads to regress or incoherence.

Lean currently has no built-in way to express this distinction.
All derivatives are treated as functions on the same level.
There is no ontological grading of change.

This makes it impossible to cleanly formalize the claim that
jerk is fundamental while higher derivatives are not.
-/