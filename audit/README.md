# audit/

Audit of the Lean listing in Section 4.1 of the T.O.N.E. paper (January 2026), which is described there as "fully formalised and verified in Lean 4".

| File | Purpose | Result |
|------|---------|--------|
| `Verbatim_TONE_listing.lean` | The listing, with only PDF spacing artifacts normalized and imports collapsed to `import Mathlib` | Does not compile (Lean 4.34.1, Mathlib v4.34.1): 10 errors, exit code 1 |
| `TONE_repaired.lean` | Smallest well-typed version of the same statements | Compiles; the headline theorem depends only on `propext` and `Quot.sound` |

These files are not part of the default `lake build`. Run each with `lake env lean audit/<file>`.

## Failure layer of the verbatim listing

All failures are at the elaboration layer. Lean never reaches the logic of the argument.

1. `ontologically_stable` uses `not`, which in Lean 4 is Boolean negation (`Bool -> Bool`). The argument is a `Prop`. (line 20)
2. The three axioms use `OntologicalInstability.statics` and `.regress`, which are values, where a proposition is required: "type expected". (lines 23, 26, 29)
3. The two lemmas repeat the `not` error. The later `introN` errors are consequences of it. (lines 32, 33, 39, 40)
4. The main proof has unsolved goals and then stops at a parse error ("unexpected identifier; expected command", line 49), because the `constructor` branches are not bulleted.

## What the repaired file shows

- With `Statics` and `Regress` as predicates and `Stable` a function of `n`, the headline theorem is a short consequence of the three axioms.
- The number 3 is an input: `unique_stable_level_at` proves the same statement for any `k`, and a second model places the unique stable level at 7.
- A concrete model satisfies the repaired axioms, so they are consistent.

In the original, `ontologically_stable n` does not depend on `n` and, had it type-checked, would be a false proposition. So the substantive content of the result enters through the axioms, not through any derivation.

## Scope

This audit addresses the listing as a formal object. It makes no claim about the physical or philosophical content of the paper.
