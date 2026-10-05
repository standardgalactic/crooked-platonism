# Crooked Platonism

Notes and checked experiments on Lean's foundations, on set theory, and on the TONE proposal.

This repository is a fork of `frintroper/LeanIsCorrupted`. The phrase "crooked Platonism" comes from the original README, where it names the view that Lean distorts a true ontology. Here it names a question: which ontological commitments does a formal foundation carry, and what can a formalization show about them? The original documents are kept under `upstream/` for comparison.

## What is here

| Folder | Contents |
|---|---|
| `CrookedPlatonism/` | Lean 4 experiments, built with Lake. Each file states its status and scope in a header. |
| `docs/` | Rewritten notes: what Lean assumes, how set theory and type theory relate, and where formalizations break. |
| `simulations/` | Counterfactual designs for testing the TONE claims, and numerical experiments as they are added. |
| `essay/` | A longer essay on the argument forms involved (LaTeX source and PDF). |
| `upstream/` | The original documents and Lean attempts, unchanged. |

## Running the experiments

```
lake build
```

The build prints the output of each `#print axioms` line. Those messages are the evidence for the claims about choice: a theorem that lists no `Classical.choice` does not depend on it.

## What the checked experiments show

- **EmptySet.** In Lean, emptiness is a property of a type or of a predicate. The empty type is itself a term of `Type`. This file only shows how Lean encodes emptiness.
- **Choice.** Dependence on choice is theorem-specific and inspectable. Some theorems depend on no axioms, and `Classical.choice` appears only where it is used.
- **FailureLayers.** A formalization can fail at the elaboration layer, the tactic layer, the kernel layer, or through a derived contradiction. A tactic that fails does not show that its statement is unprovable by another route.
- **Embedding.** A claim can be derivable in one represented theory and not in another. A shortfall inside a represented theory is a fact about its rules.
- **Tifu.** A satirical theorem whose proof returns its hypothesis, included to mark the difference between assuming a claim and supporting it.

The Mathlib files under `CrookedPlatonism/Mathlib/` are staged and not yet built. They will be listed here once they compile.

## Status vocabulary

Every document and Lean file marks its claims with one of these labels:

| Label | Meaning |
|---|---|
| Definition | A stipulation. |
| Theorem | Proved from stated premises, and machine checked where it is a Lean file. |
| Empirical | Depends on evidence beyond the formal statement. |
| Design rule | A recommended practice. |
| Analogy | A comparison that does not itself establish a result. |
| Conjecture | A proposal with heuristic or partial support, short of proof. |

## What this repository does not claim

It does not claim that TONE is false, and it does not claim that any foundation is neutral. Foundations carry commitments, and the notes below name some real ones. The claim under test is narrower: that a particular formalization attempt breaking shows the underlying foundation to be ontologically corrupt. The experiments are designed so that this claim can be examined directly.
