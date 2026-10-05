# Counterfactuals

Status: design rule and conjecture. The designs below are proposals. None has been run.

Scope: a framework for testing the claims that a foundation without the empty set, without choice, or with jerk as a ceiling would support a clean formalization of TONE. The question is empirical: build the alternative and see.

The Lean definition `def empty_exists : Type := Empty` from the original note compiles. It shows that `Empty` is a type that can be named, which is the sense in which it "exists" in Lean. Whether that matters for TONE is what the experiments below are meant to determine.

## 1. Without the empty set or empty type

**The claim.** Lean's acceptance of emptiness distorts any attempt to reject it.

**A design.** State the TONE content with every carrier required to be inhabited. In Lean this is a structure that bundles a carrier with an element:

```
structure InhabitedCarrier where
  carrier : Type
  elem : carrier
```

Formalize the TONE statements over such carriers and check whether any statement needs an empty carrier. If none does, rejecting emptiness costs nothing in this development. If one does, record exactly which and why.

**A control.** Repeat the exercise in a system where falsity is primitive and not defined through an empty type, and compare.

## 2. Without arbitrary choice

**The claim.** Working without choice makes standard constructions unusable.

**A design.** Develop the TONE statements in core Lean, with no Mathlib, and run `#print axioms` on each theorem. Any theorem that lists `Classical.choice` is flagged, and the dependence is examined: is it essential, or an artifact of a library lemma?

**A control.** Run the same statements in a system where choice is not available by default. The conjecture to test is that a nontrivial part of the content survives with no choice at all.

## 3. Jerk as a ceiling

**The claim.** Lean has no structural place for "jerk is the highest admissible order".

**A design.** Express the claim as a predicate on trajectories, in the Mathlib stage:

```
def HasJerkOrder (x : ℝ → ℝ) : Prop :=
  ContDiff ℝ 3 x ∧ ∀ t, ¬ DifferentiableAt ℝ (iteratedDeriv 3 x) t
```

Then examine what follows. Does a physically meaningful class of trajectories satisfy it? What is the relation to the self-inversion axiom `j = 1/j` and its role (see `CrookedPlatonism/Mathlib/Jerk.lean`)? The corresponding experiments are `Jerk.lean` and `TifuOrders.lean`.

**A numerical companion.** `simulations/jerk_regress.py` is planned to check that the regress argument is symmetric: the same argument that selects order 3 selects any other order equally well.

## 4. Whole-system test

**The claim.** Lean as a whole fails to host TONE.

**A design.** Host TONE as a deep embedding (a syntax, a derivation relation, and the intended rules) and ask what Lean says about it. The result will be a set of derivable and underivable claims in the object theory. Those results describe TONE's rules. They are only informative about Lean if some of them cannot be established, and then the layer classification in `docs/Where_Formalizations_Break.md` applies.

## 5. What would change the assessment

A minimal failing example, classified at the kernel layer or as a derived contradiction, that is reproduced in a control system lacking the empty type and choice and is absent there. Even then, the outcome is separate for each case: a kernel defect concerns an implementation, an incompatibility concerns assumptions, and a dependence concerns the particular formal commitments. Ontological corruption would need its own criterion.
