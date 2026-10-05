/-!
# Tifu

Status: theorem, deliberately trivial.

Scope: satire about argument form. The theorem returns its hypothesis, so it
does not support the hypothesis. The hypothesis that a sixth derivative is
primitive is not supported by this file either. (Unrelated to the Pop
primitive in the Spherepop calculus.)
-/

namespace CrookedPlatonism.Tifu

/-- Assume that pop is primitive. Then pop is primitive. -/
theorem tifu (PopIsPrimitive : Prop) (h : PopIsPrimitive) : PopIsPrimitive := h

/-- The device does not choose an order: any proposition is "established"
this way, including its own negation, under a hypothesis that says so. -/
theorem tifu_negation (P : Prop) (h : ¬ P) : ¬ P := h

end CrookedPlatonism.Tifu
