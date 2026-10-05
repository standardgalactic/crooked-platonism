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
