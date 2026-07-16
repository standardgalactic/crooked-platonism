# What If Lean Was Different?

This document explores what would need to fundamentally change in Lean for a clean and undistorted formalization of TONE to become possible.

The required changes are not improvements in tactics, automation, or library size. They are ontological.

## 1. Treatment of the Empty Set

**Current state in Lean:**
Lean treats the empty type as a valid, existing object that can be freely used in constructions and proofs.

**What TONE requires:**
The empty set must not be granted ontological legitimacy. Treating "nothing" as something is already a foundational error.

**What would need to change:**
Lean would have to stop treating emptiness as a default-valid case. This cannot be achieved with a few additional lemmas. It would require changes at the level of how types and existence are conceptualized in the system.

Without this change, any attempt to reject the empty set will either be forced to accept it anyway or will require constant, distorting workarounds.

## 2. Status of Arbitrary Choice

**Current state in Lean:**
The Axiom of Choice is available and is used (explicitly or implicitly) in many standard constructions.

**What TONE requires:**
Arbitrary choice is ontologically illegitimate. It permits separations without grounding.

**What would need to change:**
Lean would have to make the rejection of arbitrary choice a coherent and workable default position, rather than a restriction that breaks large parts of the mathematical ecosystem.

This would not be a small adjustment. It would affect how existence, functions, and many standard proofs are handled.

## 3. Status of Jerk

**Current state in Lean:**
Jerk (the third derivative) is treated as just another higher-order derivative with no special ontological status.

**What TONE requires:**
Jerk is the highest ontologically admissible form of change. Higher derivatives lead to regress or incoherence.

**What would need to change:**
Lean would have to allow (or even prioritize) the position that jerk is fundamental, while higher derivatives are not. Currently, there is no structural category in Lean that supports this distinction. All derivatives are treated as functions on the same level.

## Conclusion

These three changes are not incremental improvements. They are foundational.

If Lean made these changes, a clean formalization of TONE would become possible without constant distortion.  
Because Lean does **not** make these changes, the formalization collapses at predictable points.

This is not a problem of implementation.  
This is a problem of ontology.
def empty_exists : Type := Empty