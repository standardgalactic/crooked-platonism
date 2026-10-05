/-!
# Embedding

Status: analogy plus theorem (a toy deep embedding, with checked statements).

Scope: a theory hosted as data is judged by its own rules. Whether a claim is
derivable is then a fact about the rule set, and a shortfall there is not an
error in Lean. The toy theory below is not TONE. It only shows the pattern.
-/

namespace CrookedPlatonism.Embedding

/-- Claims of a toy theory of derivative orders. -/
inductive Claim where
  | primitiveOrder (n : Nat)
  deriving DecidableEq

/-- Theory A: only order 3 is primitive. -/
inductive DerivableA : Claim → Prop where
  | three : DerivableA (.primitiveOrder 3)

/-- Theory B: orders 3 and 6 are both primitive. -/
inductive DerivableB : Claim → Prop where
  | three : DerivableB (.primitiveOrder 3)
  | six   : DerivableB (.primitiveOrder 6)

/-- In theory A, order 6 is not derivable. -/
theorem not_derivableA_six : ¬ DerivableA (.primitiveOrder 6) := by
  intro h
  cases h

/-- In theory B it is. The difference lies in the rule sets. -/
theorem derivableB_six : DerivableB (.primitiveOrder 6) := .six

/-- Nothing in Lean decided between the theories. -/
example : ¬ DerivableA (.primitiveOrder 6) ∧ DerivableB (.primitiveOrder 6) :=
  ⟨not_derivableA_six, derivableB_six⟩

end CrookedPlatonism.Embedding
