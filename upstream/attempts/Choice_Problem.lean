/-
This file shows the tension between TONE and Lean's treatment
of arbitrary choice.
-/

-- Lean allows (and often relies on) the Axiom of Choice:
noncomputable def arbitrary_choice {α : Type} (P : α → Prop)
  (h : ∀ x, ∃ y, P y) : α :=
  Classical.choose (Classical.choice h)

/-
TONE views unrestricted arbitrary choice as ontologically illegitimate.
It allows separations and selections without any deeper grounding.

When one attempts to formalize TONE's rejection of arbitrary choice,
many standard constructions in Lean become unavailable or require
heavy modifications. The system is not designed to treat the
rejection of choice as a coherent default position.

This creates constant structural friction.
-/