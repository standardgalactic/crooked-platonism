/-!
# EmptySet

Status: theorem (each result below is checked by the Lean kernel).

Scope: this file shows how Lean represents emptiness. It makes no claim about
what exists in the world. The claim it supports is narrow: in Lean, "empty"
describes a type or a predicate, and the empty type is itself an object.
-/

namespace CrookedPlatonism.EmptySet

/-- `Empty` is a type, so it is itself a term of `Type`. It is not "nothing". -/
def emptyIsAType : Type := Empty

/-- The empty type has no inhabitants. -/
theorem not_nonempty_empty : ¬ Nonempty Empty := fun ⟨e⟩ => nomatch e

/-- The empty set of `α`, encoded as a predicate that is never true. -/
def emptySet (α : Type) : α → Prop := fun _ => False

theorem emptySet_has_no_members (α : Type) (a : α) : ¬ emptySet α a :=
  fun h => h

/-- Negation is implication into `False`. Emptiness of a type and falsity of a
proposition are two encodings of the same idea, not an extra ontological
commitment. -/
theorem not_iff_imp_false (p : Prop) : (¬ p) ↔ (p → False) := Iff.rfl

/-- A function out of the empty type exists for every target. -/
def fromEmpty (α : Type) : Empty → α := fun e => nomatch e

end CrookedPlatonism.EmptySet
