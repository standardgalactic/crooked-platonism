
<<<FILE: ./README.md>>>
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
<<<END: ./README.md>>>

<<<FILE: ./docs/Foundations_of_Lean.md>>>
# Foundations of Lean

Status: definition and theorem for statements about the kernel and the experiment files; design rule for the recommendations; conjecture where noted.

Scope: what Lean's logic commits to, and which of those commitments bear on the three TONE claims (the empty set, arbitrary choice, and the status of jerk). Nothing here is a claim about physics.

## 1. What the kernel is

Lean 4 is built on a dependent type theory with a hierarchy of universes, an impredicative universe of propositions (`Prop`), inductive types, quotient types, and proof irrelevance. It is not a set theory. Sets are defined on top of it: in Mathlib, a set of elements of `α` is a function `α → Prop`, and a development of ZF-style sets (`ZFSet`) exists as a library for those who want it.

The relationship to ZFC is one of relative consistency strength. Carneiro (2019) showed that Lean's core theory is consistent relative to ZFC with countably many inaccessible cardinals. That is a statement about comparable strength. It does not make Lean's ontology the ontology of ZFC.

Two other systems are set-theoretic in the strict sense, for contrast: Metamath's `set.mm` and Mizar, which is based on Tarski–Grothendieck set theory.

## 2. Empty types, empty sets, and falsity

Lean has an empty type, `Empty`, with no constructors. It is an object: a term of `Type`. Lean also has `False`, the empty proposition, and defines negation as implication into it: `¬ p` unfolds to `p → False`.

Three claims follow, each checked in `CrookedPlatonism/EmptySet.lean`:

- The empty type has no inhabitants (`not_nonempty_empty`).
- An empty set of `α` is a predicate that is never true (`emptySet`, `emptySet_has_no_members`).
- Negation is implication into `False` (`not_iff_imp_false`), so emptiness of a type and falsity of a proposition are two encodings of one idea.

This encoding is a design choice of type theories in this family. Other logical systems take falsity or negation as primitive. So "Lean needs the empty type" is true of Lean's encoding of negation and is a statement about that encoding.

A philosophical position that "nothing" should not be treated as an object is a position about ontology. It is worth stating on its own terms. The empty set is not "nothing" in that sense: it is a set that has no members, and it is an object like any other set. A system could decline to form such objects. That is a different system from Lean, and the question of which is better is not answered by Lean's behaviour.

## 3. Choice

Lean's core includes the axiom `Classical.choice`. Whether a given theorem depends on it is inspectable: `#print axioms` lists every axiom a theorem uses.

`CrookedPlatonism/Choice.lean` records five cases. A theorem about `2 + 2 = 4` depends on no axioms. Selecting an element from a given element, or the head of a known nonempty list, needs none. `Classical.em` depends on `[propext, Classical.choice, Quot.sound]`. Picking an element from a type known only to be nonempty depends on `Classical.choice`.

So the claim that "Lean proofs inherently depend on choice" is false as a blanket statement, and the claim that "a given proof depends on choice" is a question with a mechanical answer. A choice-free development is possible in Lean and can be audited the same way. Mathlib itself is classical by default, which is a convention of that library and not of the kernel.

Choice is also independent of the other axioms of set theory (Gödel 1938, Cohen 1963), and the axiom of separation, which carves a subset out of a given set, is a different principle from choice. Neither point is a technical fact about Lean.

## 4. Derivatives and the status of jerk

Lean treats a derivative as a function. It does not attach an ontological grade to its order, and neither does ordinary calculus. That is a feature of the mathematics.

TONE's central claim, that jerk is the highest admissible order of change, is a claim about what a model should include. It can be expressed in Lean as a predicate on trajectories. For example, "x is three times continuously differentiable and its third derivative is not differentiable anywhere" is a predicate that can be stated (and satisfied; such functions exist, for instance as the triple integral of a nowhere-differentiable function). That reading, a restriction on the class of admissible models, is expressible without any change to Lean.

The stronger reading, that derivatives beyond jerk are incoherent, is a physical or philosophical thesis. There are physical arguments around it: Lagrangians that depend on derivatives beyond acceleration run into the Ostrogradsky instability, and the Abraham–Lorentz force involves jerk. Those are arguments about physics. They are separate from what Lean can or cannot represent.

## 5. Commitments Lean does carry

A foundation is not neutral, and it is better to say plainly where Lean has commitments:

- **Proof irrelevance and impredicative `Prop`.** Any two proofs of the same proposition are definitionally equal. This is convenient and is a real commitment.
- **Uniqueness of identity proofs.** Equality in `Prop` makes any two proofs of an equality identical, which is incompatible with univalence. Anyone who wants univalent foundations will find this a genuine limit.
- **Classical defaults.** Mathlib assumes classical logic and choice throughout. A development that wants to avoid them has to leave much of Mathlib behind.
- **A universe hierarchy.** Statements about "all types" are stratified.

These commitments are the real subject of foundational disagreement about Lean. None of them is the empty set, and none is choice as an obstacle to a statement being formalized.

## 6. Where this leaves the three claims

| TONE claim | What Lean does | Where the real question lies |
|---|---|---|
| The empty set should not be granted existence | Encodes emptiness as a property of types and predicates | A philosophical position about ontology, independent of Lean |
| Arbitrary choice is illegitimate | Provides it as an axiom and reports every use | Which development to build, and with which library |
| Jerk is the highest admissible order | Expresses it as a predicate on trajectories | A physical thesis, to be argued with physics |

## Sources

Carneiro, M. (2019), *The Type Theory of Lean*. Gödel (1938) and Cohen (1963) on the independence of choice. Quine (1948), "On What There Is". Ostrogradsky (1850). The Lean 4 reference manual and Mathlib documentation for the kernel, `Set`, and `ZFSet`.
<<<END: ./docs/Foundations_of_Lean.md>>>

<<<FILE: ./docs/ZFC_and_Type_Theory.md>>>
# ZFC and Type Theory

Status: definition and theorem for the standard facts; analogy for the comparison of foundations; conjecture where noted.

Scope: how set theory and type theory relate, and what it would take for a foundation to count as "failing". This note does not argue for or against any ontology.

## 1. What ZFC is

ZFC is a first-order theory of sets with a small collection of axioms: extensionality, pairing, union, power set, infinity, separation, replacement, foundation, and choice. Most of ordinary mathematics can be interpreted in it. It is not the only foundation. Type theories, category-theoretic foundations, and weaker set theories are also used, and each interprets a different range of mathematics with a different cost.

## 2. The empty set

In ZFC, the existence of the empty set follows from the existence of at least one set, together with separation: take any set and select the elements satisfying a contradictory condition. The result is a set with no members. It is not a stand-in for absence. It is a particular set, and extensionality guarantees there is only one.

Two positions need to be kept apart. A view that the empty set should not count as an object is a coherent position in the philosophy of mathematics. Quine's discussion of ontological commitment ties what we are committed to with what our quantifiers range over, and the null class has been debated in that tradition. A view that the empty set is an error of being, so that a foundation which includes it is false, is a much stronger claim and would need an independent criterion for what makes a foundational commitment false. The existence of a coherent alternative is not such a criterion.

## 3. Choice

The axiom of choice is independent of the other axioms (Gödel 1938 for consistency, Cohen 1963 for independence). Mathematicians work with it, without it, and with weaker forms of it. Constructive and type-theoretic foundations typically do not assume it by default. Its consequences are well known: it yields results such as the well-ordering of the reals and the Banach–Tarski decomposition, and it implies excluded middle in a suitable setting (Diaconescu 1975, Goodman and Myhill 1978).

Choice is a principle about the existence of selection functions. Calling it "arbitrary distinction" is an interpretation of it. The interpretation is a philosophical one and can be argued, but the question is separate from the axiom's formal status.

## 4. Relating the two

A type theory such as Lean's interprets sets as types or predicates and proves ZFC-style statements as theorems of its own theory. Lean's consistency strength is comparable to ZFC with inaccessible cardinals (Carneiro 2019). Being comparable in strength is not the same as being ZFC, and a system can be hosted inside another without inheriting its ontology. A formalization of a physical or philosophical theory in Lean is an object-level encoding. Its failures are failures of that encoding first.

## 5. What would count as a foundation failing

There are several distinct outcomes, and they should not be merged:

1. **Inconsistency.** A derivation of a contradiction from the axioms. For ZFC no such derivation is known. By Gödel's second incompleteness theorem, ZFC cannot prove its own consistency, so the status of that question is a matter of established research and not of one formalization attempt.
2. **Inadequacy.** The foundation cannot express or derive some intended mathematics. This is a limit to be shown by a specific statement and a proof of its inexpressibility.
3. **Inconvenience.** The foundation can express the mathematics, but awkwardly. This is a fact about the development and the tooling.
4. **Disagreement.** The foundation commits to something that one party rejects on philosophical grounds. This is a real and ongoing debate, and no formal result settles it.

The original argument moves from outcome 3 or 4 to a conclusion in outcome 1. That inference needs a bridge, and the bridge is the thing missing from the argument.

## 6. A fair statement of the position

Someone who holds that a foundation should avoid the empty set and unrestricted choice is holding a position that has serious precedents: free logics, constructive mathematics, and various finitist and predicativist programmes. The strongest version is "here is a foundation with these properties, and here is the mathematics it supports". That is a constructive project, and it is one the Lean experiments in this repository are meant to serve: any such foundation, if it is stated precisely, can be hosted as a deep embedding and examined by the same tools.

## Sources

Gödel (1938). Cohen (1963). Diaconescu (1975). Goodman and Myhill (1978). Quine (1948), "On What There Is"; Quine (1963), *Set Theory and Its Logic*. Carneiro (2019), *The Type Theory of Lean*.
<<<END: ./docs/ZFC_and_Type_Theory.md>>>

<<<FILE: ./docs/Where_Formalizations_Break.md>>>
# Where Formalizations Break

Status: design rule (a classification and a checklist), illustrated by checked examples in `CrookedPlatonism/FailureLayers.lean` and `CrookedPlatonism/Embedding.lean`.

Scope: how to read a failed formalization attempt. This note is a method. It makes no claim about any particular foundation.

## 1. The question

When an attempt to formalize a theory in a proof assistant stalls, the stall is data about the attempt. Which layer it belongs to determines what it can be evidence for.

## 2. Four layers

| Layer | What failed | What it is evidence about |
|---|---|---|
| Elaboration | The statement does not typecheck | The way the statement was written |
| Tactic | The statement is fine, and one proof strategy finds no proof | That strategy, and nothing about the statement |
| Kernel | The kernel rejects a proof term | A defect in an implementation |
| Derived contradiction | `False` follows from the hypotheses | The hypotheses are inconsistent |

The file `FailureLayers.lean` isolates the first, second and fourth layers with small checked examples. The kernel layer cannot be shown in a file that builds, so it is described and left unexercised.

The tactic example is worth stating. `decide` cannot prove `p ∨ ¬p` for an arbitrary proposition `p`, because there is no decision procedure. The same statement is provable in one line by `Classical.em`. The tactic failure said nothing about the statement.

## 3. Failure inside a hosted theory

When a theory is hosted as data, with its own syntax and rules, a claim that is underivable in that theory is a fact about the theory's rules. `Embedding.lean` shows a toy case: in one rule set order 6 is not derivable, and in another it is. Lean verified both facts. Neither is a failure of Lean.

## 4. A checklist for reading a failure

Before inferring anything about a foundation, ask:

1. What exactly was the failing example? Reduce it to a minimal one.
2. At which layer does it fail?
3. Is there a control: the same content formalized in a system without the features blamed for the failure, or in a deep embedding?
4. Does the difficulty persist in the control? If it does, the difficulty belongs to the theory being formalized.
5. If it vanishes in the control, what does that show? It shows a dependence on particular formal commitments. It does not by itself show that a foundation is false.
6. What is the criterion for "false" or "corrupt", stated independently of the failure?

## 5. Possible outcomes, kept separate

| Outcome | What it would concern |
|---|---|
| A kernel defect | An implementation |
| An incompatibility between a theory and a set of assumptions | Those assumptions |
| A dependence on particular formal commitments | Those commitments |
| A failure to find a proof | A search procedure |

None of these alone establishes ontological corruption. That claim needs a separate criterion, and a statement of what would count against it.

## 6. A request

If you have a failing example that you believe tests a foundation, the useful form is a short Lean file, a note on the layer at which it fails, and the control you ran. The experiments here are organized to take such a file.
<<<END: ./docs/Where_Formalizations_Break.md>>>

<<<FILE: ./simulations/Counterfactuals.md>>>
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
<<<END: ./simulations/Counterfactuals.md>>>

