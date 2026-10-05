import Mathlib
import CrookedPlatonism.Mathlib.Jerk
import CrookedPlatonism.Mathlib.TifuOrders

/-!
# OrdersExclusive

Status: theorem.

Scope: for a function `x : ℝ → ℝ`, suppose the self-inversion axiom `A` (with its
nonzero clause) holds for the `m`-th derivative of `x`, and that derivative is
continuous on all of ℝ. Then `A` fails for the `n`-th derivative for every
`n > m`. So the axiom cannot hold at two different orders, and it does not
single out an order. The statement is for the whole real line. An interval
version would carry `ContinuousOn` hypotheses through the same argument.
-/

namespace CrookedPlatonism.OrdersExclusive

open CrookedPlatonism.TifuOrders (A)

/-- Under `A`, every value is `1` or `-1`. -/
theorem values (x : ℝ → ℝ) (hA : A x) (t : ℝ) : x t = 1 ∨ x t = -1 :=
  CrookedPlatonism.Jerk.self_inverse_cases (x t) (hA t).1 (hA t).2

/-- A continuous function satisfying `A` takes the same value at any two points,
because the intermediate value theorem would otherwise produce a zero. -/
theorem constant_on_interval (x : ℝ → ℝ) (hA : A x) {a b : ℝ}
    (hc : ContinuousOn x (Set.uIcc a b)) : x a = x b := by
  have hzero : ∀ c, x c ≠ 0 := fun c => (hA c).1
  rcases values x hA a with ha | ha <;> rcases values x hA b with hb | hb
  · rw [ha, hb]
  · exfalso
    have hmem : (0 : ℝ) ∈ Set.uIcc (x a) (x b) := by
      rw [ha, hb, Set.mem_uIcc]
      right
      norm_num
    obtain ⟨c, _, hc0⟩ := intermediate_value_uIcc hc hmem
    exact hzero c hc0
  · exfalso
    have hmem : (0 : ℝ) ∈ Set.uIcc (x a) (x b) := by
      rw [ha, hb, Set.mem_uIcc]
      left
      norm_num
    obtain ⟨c, _, hc0⟩ := intermediate_value_uIcc hc hmem
    exact hzero c hc0
  · rw [ha, hb]

/-- If `A` holds for the `m`-th derivative and it is continuous, every
derivative of order above `m` is identically zero. -/
theorem higher_zero (x : ℝ → ℝ) (m : ℕ)
    (hc : Continuous (iteratedDeriv m x)) (hA : A (iteratedDeriv m x)) (k : ℕ) :
    iteratedDeriv (m + 1 + k) x = fun _ => 0 := by
  have hconst : ∀ t, iteratedDeriv m x t = iteratedDeriv m x 0 := fun t =>
    constant_on_interval (iteratedDeriv m x) hA (a := t) (b := 0) hc.continuousOn
  have hfun : iteratedDeriv m x = fun _ => iteratedDeriv m x 0 := funext hconst
  have h1 : iteratedDeriv (m + 1) x = fun _ => 0 := by
    rw [iteratedDeriv_succ, hfun]
    funext t
    simp
  induction k with
  | zero => simpa using h1
  | succ k ih =>
    have e : m + 1 + (k + 1) = m + 1 + k + 1 := by omega
    rw [e, iteratedDeriv_succ, ih]
    funext t
    simp

/-- `A` cannot hold at two different orders when the lower derivative is continuous. -/
theorem orders_exclusive (x : ℝ → ℝ) {m n : ℕ} (hmn : m < n)
    (hcm : Continuous (iteratedDeriv m x)) (hm : A (iteratedDeriv m x)) :
    ¬ A (iteratedDeriv n x) := by
  intro hn
  obtain ⟨k, rfl⟩ : ∃ k, n = m + 1 + k := ⟨n - m - 1, by omega⟩
  have hz := higher_zero x m hcm hm k
  have h0 := (hn 0).1
  rw [hz] at h0
  exact h0 rfl

/-- The case in the appendix: orders 3 and 6. -/
theorem three_six (x : ℝ → ℝ) (hc : Continuous (iteratedDeriv 3 x)) :
    ¬ (A (iteratedDeriv 3 x) ∧ A (iteratedDeriv 6 x)) :=
  fun ⟨h3, h6⟩ => orders_exclusive x (by norm_num : 3 < 6) hc h3 h6

#print axioms orders_exclusive
#print axioms three_six

end CrookedPlatonism.OrdersExclusive
