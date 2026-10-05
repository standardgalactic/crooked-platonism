/-!
# FailureLayers

Status: design rule (a classification) illustrated by small checked examples.

Scope: when a formalization "fails", the failure can sit at different layers.
Each example below isolates one layer. None of them is evidence about a
foundation.

1. Elaboration: the statement does not typecheck.
2. Tactic: the statement is fine, but one proof strategy finds no proof.
3. Kernel: the kernel rejects a proof term. This would be a defect in an
   implementation. It cannot be demonstrated in a file that builds, so it is
   described here and left unexercised.
4. Derived contradiction: a hypothesis set is inconsistent, and `False` follows.
-/

namespace CrookedPlatonism.FailureLayers

/-- Layer 1: an ill-typed statement is an elaboration failure.
`fail_if_success` turns the expected failure into a success. -/
example : True := by
  fail_if_success exact (rfl : 2 + 2 = 5)
  trivial

/-- Layer 2: `decide` cannot prove `p ∨ ¬p` for an arbitrary `p`
(there is no `Decidable` instance). That is a tactic failure. -/
example (p : Prop) : True := by
  fail_if_success (have : p ∨ ¬p := by decide)
  trivial

/-- The same statement is provable by a different route, so the tactic
failure said nothing about the statement. -/
example (p : Prop) : p ∨ ¬p := Classical.em p

/-- Layer 4: from inconsistent hypotheses, `False` follows. The contradiction
belongs to the hypotheses. -/
theorem derived_contradiction (h : (1 : Nat) = 2) : False := by omega

/-- Without the bad hypothesis there is no contradiction. -/
theorem consistent_without_it : (1 : Nat) = 1 := rfl

end CrookedPlatonism.FailureLayers
