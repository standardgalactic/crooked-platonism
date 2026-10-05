# Crooked Platonism

Checked experiments, an audit, and two essays on the foundations of logic, set theory, and Lean.

The question the repository works on: which ontological commitments does a formal foundation carry, and what can a formalization show about them? Claims are kept at the level they can be checked. A Lean file is judged by what the kernel accepts, a result is reported with its axiom footprint, and a conclusion about a foundation is separated from a conclusion about one formalization of it.

## Start here

| If you want | Read |
|---|---|
| A full development of logic, ZFC, and dependent type theory from four operators (Pop, Refuse, Bind, Collapse), with a reproducibility protocol | `essay/rebuilding-foundations.pdf` |
| A shorter essay on the argument forms involved when a formalization breaks | `essay/formal_failure_and_ontological_overreach.pdf` |
| A worked check of a published Lean listing | `audit/README.md` |
| Plain-language notes on what Lean assumes | `docs/Foundations_of_Lean.md` |

## The essays

**Rebuilding the Foundations of Logic: Sets, Type Theory, and Reproducibility** (`essay/rebuilding-foundations.tex`, `.pdf`). A monograph that builds logic from four operators: Pop introduces an item, Refuse restricts a domain, Bind relates or abstracts, and Collapse evaluates or identifies. From these it develops Boolean and intuitionistic semantics, first-order logic, ZFC, and the kernel of a Lean-style dependent type theory, including the Curry-Howard correspondence and a worked kernel derivation. Its central thesis is that axioms such as Choice and the Zermelo-Fraenkel axioms are conventions: not forced, but valuable because they give everyone a common language, and determinate in their consequences once fixed. It closes with a reproducibility protocol (base, footprint, layer, declared axioms, scope, environment, controls) and a case study in a non-integer radix. Every statement carries a status label (see below).

**Formal failure and ontological overreach** (`essay/formal_failure_and_ontological_overreach.tex`, `.pdf`). A shorter essay on what can and cannot be inferred from the failure of a formalization.

## What is here

| Folder | Contents |
|---|---|
| `CrookedPlatonism/` | Lean 4 experiments, built with Lake. Each file states its status and scope in a header. |
| `audit/` | A check of a published Lean listing: the verbatim file, a repaired neighbor, and a README recording what was run and what happened. |
| `docs/` | Notes: what Lean assumes, how set theory and type theory relate, and where formalizations break. |
| `simulations/` | Counterfactual designs for testing the TONE claims, and numerical experiments as they are added. |
| `essay/` | The two essays above, LaTeX source, PDF, audio overviews and transcripts. |
| `tools/` | Setup and maintenance scripts. |
| `upstream/` | Original documents and Lean attempts, unchanged (see footnote 1). |

## Running the experiments

```
lake build
```

The build prints the output of each `#print axioms` line. Those messages are the evidence for the claims about choice: a theorem that lists no `Classical.choice` does not depend on it.

The audit files are checked individually:

```
lake env lean audit/Verbatim_TONE_listing.lean
lake env lean audit/TONE_repaired.lean
```

The Mathlib files build under Lean 4.34.1 with Mathlib v4.34.1. Their axiom dependencies, printed by the build, include Mathlib's classical axioms.

## What the checked experiments show

- **EmptySet.** In Lean, emptiness is a property of a type or of a predicate. The empty type is itself a term of `Type`. This file only shows how Lean encodes emptiness.
- **Choice.** Dependence on choice is theorem-specific and inspectable. Some theorems depend on no axioms, and `Classical.choice` appears only where it is used.
- **FailureLayers.** A formalization can fail at the elaboration layer, the tactic layer, the kernel layer, or through a derived contradiction. A tactic that fails does not show that its statement is unprovable by another route.
- **Embedding.** A claim can be derivable in one represented theory and not in another. A shortfall inside a represented theory is a fact about its rules.
- **Tifu.** A satirical theorem whose proof returns its hypothesis, included to mark the difference between assuming a claim and supporting it.
- **Jerk** (needs Mathlib). The conditional algebra `j = 1/j` with `j ≠ 0` gives `j = ±1`. Under Mathlib's total convention `1/0 = 0` the value `j = 0` also satisfies the equation, so the reciprocal convention matters.
- **TifuOrders** (needs Mathlib). The self-inversion axiom, with its nonzero clause, fails for the derivative of any constant function. This is the step behind the claim that axioms for two different orders cannot both hold.
- **ConstantJerk** (needs Mathlib). The function `t ↦ t³/6` has third derivative identically 1, so a smooth trajectory with constant jerk exists. The equation `j = 1/j` is consistent with it, and the equation alone does not exclude anything smooth beyond fixing the value of the third derivative.
- **OrdersExclusive** (needs Mathlib). If the self-inversion axiom, with its nonzero clause, holds for the m-th derivative of a function and that derivative is continuous on the real line, it fails for every higher order. The axiom therefore cannot hold at two orders (for example 3 and 6), and it does not select an order.

## What the audit shows

The audit checks the Lean listing published with the TONE paper (Lean 4.34.1, Mathlib v4.34.1).

- The verbatim listing does not compile. It fails at the elaboration layer with 10 errors: `not` is used where `¬` on `Prop` is meant, constructor terms are used where a proposition is required, and unbulleted `constructor` branches cause a parse error.
- A repaired neighbor of the listing compiles.
- In the repaired file, the "unique stable level 3" theorem is a restatement of its three declared axioms. It is a correct derivation, and by the relative-result principle it establishes the implication from those axioms rather than an independent result.
- Scope: the formal object only. The audit says nothing about the physical claims of the paper.

Details, commands, and outputs are in `audit/README.md`.

## Status vocabulary

Every document and Lean file marks its claims with one of these labels.

| Label | Meaning |
|---|---|
| Definition | A stipulation. |
| Theorem, Proposition, Lemma, Corollary | Proved from stated premises, and machine checked where it is a Lean file. |
| Cited result | Proved in the literature and used here without proof, with a reference. |
| Computation | Checked by running code or a finite calculation. |
| Empirical | Depends on evidence beyond the formal statement. |
| Design rule | A recommended practice. |
| Analogy | A comparison that does not itself establish a result. |
| Conjecture | A proposal with heuristic or partial support, short of proof. |

## What this repository does not claim

It does not claim that TONE is false, and it does not claim that any foundation is neutral. Foundations carry commitments, and the notes name some real ones. The claim under test is narrower: that a particular formalization attempt breaking shows the underlying foundation to be ontologically corrupt. The experiments and the audit are designed so that this claim can be examined directly.

It also does not claim that the monograph's operator correspondences are theorems about Lean or ZFC. An operator correspondence has mathematical content only when its domain, interpretation, and preserved structure are specified; otherwise it is notation or analogy, and the monograph labels it as such.

## Footnotes

<sup>1</sup> This repository is a fork of `frintroper/LeanIsCorrupted`. The phrase "crooked Platonism" comes from that repository's README, where it names the view that Lean distorts a true ontology. Here it names a question: which ontological commitments a formal foundation carries. The original documents and Lean attempts are kept under `upstream/` unchanged, for comparison.
