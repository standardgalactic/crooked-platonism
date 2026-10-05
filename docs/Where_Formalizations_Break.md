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
