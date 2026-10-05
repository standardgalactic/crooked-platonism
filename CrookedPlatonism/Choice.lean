/-!
# Choice

Status: theorem (statements) plus empirical output (the `#print axioms` lines,
which report what the kernel recorded).

Scope: the `#print axioms` messages show which axioms a given theorem depends
on. A theorem that lists no `Classical.choice` does not use it. This is how
one checks a claim about choice, instead of asserting it.
-/

namespace CrookedPlatonism.Choice

theorem two_add_two : 2 + 2 = 4 := rfl
-- expect: does not depend on any axioms
#print axioms two_add_two

/-- Excluded middle, as proved in core Lean, goes through choice. -/
theorem em_for_all (p : Prop) : p ∨ ¬p := Classical.em p
-- expect: propext, Classical.choice, Quot.sound
#print axioms em_for_all

/-- Picking an element from a type known only to be nonempty needs choice. -/
noncomputable def pick {α : Type} (h : Nonempty α) : α := Classical.choice h
-- expect: Classical.choice
#print axioms pick

/-- Choosing from a *given* element needs no axiom at all. -/
def pickGiven {α : Type} (a : α) : α := a
-- expect: does not depend on any axioms
#print axioms pickGiven

/-- Choosing the head of a nonempty list needs no axiom either. -/
def headOfNonempty {α : Type} : (l : List α) → l ≠ [] → α
  | a :: _, _ => a
  | [], h => absurd rfl h
-- expect: does not depend on any axioms
#print axioms headOfNonempty

end CrookedPlatonism.Choice
