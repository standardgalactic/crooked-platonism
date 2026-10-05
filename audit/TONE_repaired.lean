/-
  Neighboring formulations of the T.O.N.E. Lean listing.
  Part 1: the smallest repair that makes the statements well typed.
  Part 2: what the repaired theorem actually depends on.
  Part 3: the number 3 is an input, not an output.
  Part 4: a model showing the repaired axioms are consistent (no free lunch, no contradiction).
  Untested when written; compile and report.
  Run:  lake env lean audit/TONE_repaired.lean
-/
import Mathlib

namespace ToneRepair

/-- The two "instability" notions are predicates on levels, not constructor terms. -/
structure Setup where
  Statics : ℕ → Prop
  Regress : ℕ → Prop

/-- Stable means neither statics nor regress, and it depends on n. -/
def Stable (S : Setup) (n : ℕ) : Prop := ¬ S.Statics n ∧ ¬ S.Regress n

/-- The three axioms, stated as hypotheses about a setup. -/
structure Axioms (S : Setup) : Prop where
  low : ∀ n, n ≤ 2 → S.Statics n
  high : ∀ n, 4 ≤ n → S.Regress n
  three : ¬ S.Statics 3 ∧ ¬ S.Regress 3

/-- The headline theorem, now well typed. It is a short consequence of the axioms. -/
theorem unique_stable_level (S : Setup) (A : Axioms S) :
    {n : ℕ | Stable S n} = {3} := by
  ext n
  simp only [Set.mem_setOf_eq, Set.mem_singleton_iff]
  constructor
  · intro h
    by_contra hn
    rcases Nat.lt_or_ge n 3 with h3 | h3
    · exact h.1 (A.low n (by omega))
    · exact h.2 (A.high n (by omega))
  · rintro rfl
    exact A.three

#print axioms unique_stable_level   -- expect: no axioms or only propext

/-- Part 3. Nothing special about 3: any k works with matching hypotheses. -/
theorem unique_stable_level_at (S : Setup) (k : ℕ)
    (low : ∀ n, n < k → S.Statics n) (high : ∀ n, k < n → S.Regress n)
    (hk : ¬ S.Statics k ∧ ¬ S.Regress k) :
    {n : ℕ | Stable S n} = {k} := by
  ext n
  simp only [Set.mem_setOf_eq, Set.mem_singleton_iff]
  constructor
  · intro h
    by_contra hn
    rcases Nat.lt_or_gt_of_ne hn with h3 | h3
    · exact h.1 (low n h3)
    · exact h.2 (high n h3)
  · rintro rfl
    exact hk

/-- Part 4. A concrete model of the three axioms. -/
def model : Setup := ⟨fun n => n ≤ 2, fun n => 4 ≤ n⟩

theorem model_axioms : Axioms model :=
  ⟨fun n h => h, fun n h => h, by simp [model]⟩

example : {n : ℕ | Stable model n} = {3} := unique_stable_level model model_axioms

/-- A different setup with the same machinery places the unique stable level at 7. -/
def model7 : Setup := ⟨fun n => n < 7, fun n => 7 < n⟩

example : {n : ℕ | Stable model7 n} = {7} :=
  unique_stable_level_at model7 7 (fun n h => h) (fun n h => h) (by simp [model7])

end ToneRepair

