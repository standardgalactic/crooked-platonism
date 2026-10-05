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
