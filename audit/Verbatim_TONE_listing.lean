/-
  AUDIT TARGET. Transcribed from the Lean listing in Section 4.1 of
  "Theory of Nearly Everything (T.O.N.E.)", January 2026, lines 1-57.
  Only PDF typesetting artifacts were normalized (spaces inside identifiers,
  "= >" -> "=>", "/\" kept). Nothing else was changed, including the
  parts that look like errors.
  Keep this file OUT of the default lake build.
  Run:  lake env lean audit/Verbatim_TONE_listing.lean
-/

import Mathlib

def ChangeLevel := Nat

inductive OntologicalInstability
  | statics
  | regress

def ontologically_stable (n : ChangeLevel) : Prop :=
  not (Exists (fun (_ : OntologicalInstability) => True))

axiom low_levels_statics :
  forall n : Nat, n <= 2 -> OntologicalInstability.statics

axiom high_levels_regress :
  forall n : Nat, n >= 4 -> OntologicalInstability.regress

axiom v3_neither :
  (OntologicalInstability.statics -> False) /\ (OntologicalInstability.regress -> False)

lemma low_levels_unstable (n : Nat) (hn : n <= 2) :
  not (ontologically_stable n) := by
    intro h_stable
    have h_inst := low_levels_statics n hn
    unfold ontologically_stable at h_stable
    exact h_stable (Exists.intro h_inst trivial)

lemma high_levels_unstable (n : Nat) (hn : n >= 4) :
  not (ontologically_stable n) := by
    intro h_stable
    have h_inst := high_levels_regress n hn
    unfold ontologically_stable at h_stable
    exact h_stable (Exists.intro h_inst trivial)

theorem unique_stable_level :
  { n : Nat | ontologically_stable n } = {3} := by
  apply Set.eq_singleton_iff_unique_mem.mpr
  constructor
    intro h_stable
    unfold ontologically_stable at h_stable
    push_neg at h_stable
    intro h_exists
    cases h_exists with
    | intro inst _ =>
      cases inst with
      | statics => exact v3_neither.left rfl
      | regress => exact v3_neither.right rfl
  intro n h_stable
  by_cases h_low : n <= 2
    exact absurd h_stable (low_levels_unstable n h_low)
  by_cases h_high : n >= 4
    exact absurd h_stable (high_levels_unstable n h_high)
  push_neg at h_low
  push_neg at h_high
  linarith

