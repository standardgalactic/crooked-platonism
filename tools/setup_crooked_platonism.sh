#!/usr/bin/env bash
# setup_crooked_platonism.sh
# Run from the repository root (the folder containing README.md, docs/, essay/).
#
# Creates a Lake project with core-Lean experiments (no Mathlib) and stages
# Mathlib-dependent experiments in an inert folder. Nothing existing is
# overwritten unless FORCE=1. Moving his original files into upstream/ happens
# only if MOVE_UPSTREAM=1.
#
#   bash setup_crooked_platonism.sh
#   MOVE_UPSTREAM=1 bash setup_crooked_platonism.sh
#   FORCE=1 bash setup_crooked_platonism.sh
#
# NOTE: these Lean files were written without a compiler available. Run
# `lake build` afterwards and fix any message it prints.

set -euo pipefail

FORCE="${FORCE:-0}"
MOVE_UPSTREAM="${MOVE_UPSTREAM:-0}"

if [ ! -f README.md ] || [ ! -d essay ]; then
  echo "Run this from the repository root (README.md and essay/ expected)." >&2
  exit 1
fi

# write_file PATH  (content on stdin)
write_file() {
  local path="$1"
  if [ -e "$path" ] && [ "$FORCE" != "1" ]; then
    echo "skip   $path (exists; use FORCE=1 to overwrite)"
    cat > /dev/null
    return 0
  fi
  mkdir -p "$(dirname "$path")"
  cat > "$path"
  echo "wrote  $path"
}

mkdir -p CrookedPlatonism/Mathlib simulations

# ---------------------------------------------------------------- project files

write_file lean-toolchain <<'EOF'
leanprover/lean4:v4.34.1
EOF

write_file lakefile.toml <<'EOF'
name = "CrookedPlatonism"
defaultTargets = ["CrookedPlatonism"]

[[lean_lib]]
name = "CrookedPlatonism"
EOF

write_file .gitignore <<'EOF'
# Lean / Lake
.lake/
build/
lake-manifest.json.bak

# LaTeX build artifacts
*.aux
*.fdb_latexmk
*.fls
*.log
*.out
*.toc
*.synctex.gz
*.bbl
*.blg
EOF

write_file CrookedPlatonism.lean <<'EOF'
import CrookedPlatonism.EmptySet
import CrookedPlatonism.Choice
import CrookedPlatonism.FailureLayers
import CrookedPlatonism.Embedding
import CrookedPlatonism.Tifu
EOF

# ------------------------------------------------------------------ EmptySet

write_file CrookedPlatonism/EmptySet.lean <<'EOF'
/-!
# EmptySet

Status: theorem (each result below is checked by the Lean kernel).

Scope: this file shows how Lean represents emptiness. It makes no claim about
what exists in the world. The claim it supports is narrow: in Lean, "empty"
describes a type or a predicate, and the empty type is itself an object.
-/

namespace CrookedPlatonism.EmptySet

/-- `Empty` is a type, so it is itself a term of `Type`. It is not "nothing". -/
def emptyIsAType : Type := Empty

/-- The empty type has no inhabitants. -/
theorem not_nonempty_empty : ¬ Nonempty Empty := fun ⟨e⟩ => nomatch e

/-- The empty set of `α`, encoded as a predicate that is never true. -/
def emptySet (α : Type) : α → Prop := fun _ => False

theorem emptySet_has_no_members (α : Type) (a : α) : ¬ emptySet α a :=
  fun h => h

/-- Negation is implication into `False`. Emptiness of a type and falsity of a
proposition are two encodings of the same idea, not an extra ontological
commitment. -/
theorem not_iff_imp_false (p : Prop) : (¬ p) ↔ (p → False) := Iff.rfl

/-- A function out of the empty type exists for every target. -/
def fromEmpty (α : Type) : Empty → α := fun e => nomatch e

end CrookedPlatonism.EmptySet
EOF

# -------------------------------------------------------------------- Choice

write_file CrookedPlatonism/Choice.lean <<'EOF'
/-!
# Choice

Status: theorem (statements) plus empirical output (the `#print axioms` lines,
which report what the kernel recorded).

Scope: the `#print axioms` messages show which axioms a given theorem depends
on. A theorem that lists no `Classical.choice` does not use it. This is how
one checks a claim about choice, instead of asserting it.
-/

namespace CrookedPlatonism.Choice

theorem two_add_two : 2 + 2 = 4 := rfl
-- expect: does not depend on any axioms
#print axioms two_add_two

/-- Excluded middle, as proved in core Lean, goes through choice. -/
theorem em_for_all (p : Prop) : p ∨ ¬p := Classical.em p
-- expect: propext, Classical.choice, Quot.sound
#print axioms em_for_all

/-- Picking an element from a type known only to be nonempty needs choice. -/
noncomputable def pick {α : Type} (h : Nonempty α) : α := Classical.choice h
-- expect: Classical.choice
#print axioms pick

/-- Choosing from a *given* element needs no axiom at all. -/
def pickGiven {α : Type} (a : α) : α := a
-- expect: does not depend on any axioms
#print axioms pickGiven

/-- Choosing the head of a nonempty list needs no axiom either. -/
def headOfNonempty {α : Type} : (l : List α) → l ≠ [] → α
  | a :: _, _ => a
  | [], h => absurd rfl h
-- expect: does not depend on any axioms
#print axioms headOfNonempty

end CrookedPlatonism.Choice
EOF

# ------------------------------------------------------------- FailureLayers

write_file CrookedPlatonism/FailureLayers.lean <<'EOF'
/-!
# FailureLayers

Status: design rule (a classification) illustrated by small checked examples.

Scope: when a formalization "fails", the failure can sit at different layers.
Each example below isolates one layer. None of them is evidence about a
foundation.

1. Elaboration: the statement does not typecheck.
2. Tactic: the statement is fine, but one proof strategy finds no proof.
3. Kernel: the kernel rejects a proof term. This would be a defect in an
   implementation. It cannot be demonstrated in a file that builds, so it is
   described here and left unexercised.
4. Derived contradiction: a hypothesis set is inconsistent, and `False` follows.
-/

namespace CrookedPlatonism.FailureLayers

/-- Layer 1: an ill-typed statement is an elaboration failure.
`fail_if_success` turns the expected failure into a success. -/
example : True := by
  fail_if_success exact (rfl : 2 + 2 = 5)
  trivial

/-- Layer 2: `decide` cannot prove `p ∨ ¬p` for an arbitrary `p`
(there is no `Decidable` instance). That is a tactic failure. -/
example (p : Prop) : True := by
  fail_if_success (have : p ∨ ¬p := by decide)
  trivial

/-- The same statement is provable by a different route, so the tactic
failure said nothing about the statement. -/
example (p : Prop) : p ∨ ¬p := Classical.em p

/-- Layer 4: from inconsistent hypotheses, `False` follows. The contradiction
belongs to the hypotheses. -/
theorem derived_contradiction (h : (1 : Nat) = 2) : False := by omega

/-- Without the bad hypothesis there is no contradiction. -/
theorem consistent_without_it : (1 : Nat) = 1 := rfl

end CrookedPlatonism.FailureLayers
EOF

# ----------------------------------------------------------------- Embedding

write_file CrookedPlatonism/Embedding.lean <<'EOF'
/-!
# Embedding

Status: analogy plus theorem (a toy deep embedding, with checked statements).

Scope: a theory hosted as data is judged by its own rules. Whether a claim is
derivable is then a fact about the rule set, and a shortfall there is not an
error in Lean. The toy theory below is not TONE. It only shows the pattern.
-/

namespace CrookedPlatonism.Embedding

/-- Claims of a toy theory of derivative orders. -/
inductive Claim where
  | primitiveOrder (n : Nat)
  deriving DecidableEq

/-- Theory A: only order 3 is primitive. -/
inductive DerivableA : Claim → Prop where
  | three : DerivableA (.primitiveOrder 3)

/-- Theory B: orders 3 and 6 are both primitive. -/
inductive DerivableB : Claim → Prop where
  | three : DerivableB (.primitiveOrder 3)
  | six   : DerivableB (.primitiveOrder 6)

/-- In theory A, order 6 is not derivable. -/
theorem not_derivableA_six : ¬ DerivableA (.primitiveOrder 6) := by
  intro h
  cases h

/-- In theory B it is. The difference lies in the rule sets. -/
theorem derivableB_six : DerivableB (.primitiveOrder 6) := .six

/-- Nothing in Lean decided between the theories. -/
example : ¬ DerivableA (.primitiveOrder 6) ∧ DerivableB (.primitiveOrder 6) :=
  ⟨not_derivableA_six, derivableB_six⟩

end CrookedPlatonism.Embedding
EOF

# --------------------------------------------------------------------- Tifu

write_file CrookedPlatonism/Tifu.lean <<'EOF'
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
EOF

# ---------------------------------------------------------- Mathlib (staged)

write_file CrookedPlatonism/Mathlib/README.md <<'EOF'
# Mathlib experiments (staged, not built)

Files here are not imported by `CrookedPlatonism.lean`, so `lake build` ignores
them. To enable them:

1. Pick the Mathlib release matching your Lean version (check
   https://github.com/leanprover-community/mathlib4 for its `lean-toolchain`).
2. Add to `lakefile.toml`:

       [[require]]
       name = "mathlib"
       scope = "leanprover-community"
       rev = "<tag or commit matching your toolchain>"

3. Copy that Mathlib release's `lean-toolchain` content into this repo's
   `lean-toolchain`, then run `lake update` and `lake exe cache get`.
4. Add `import CrookedPlatonism.Mathlib.Jerk` to `CrookedPlatonism.lean`.

These files were written without a compiler and may need small fixes.
EOF

write_file CrookedPlatonism/Mathlib/Jerk.lean <<'EOF'
import Mathlib

/-!
# Jerk

Status: theorem (algebra), with the convention difference stated explicitly.

Scope: the equation `j = 1/j` is checked as algebra over the reals. Whether it
constrains physical trajectories is a separate, unsupported step.
-/

namespace CrookedPlatonism.Jerk

/-- With the ordinary partial reciprocal (so `j ≠ 0`), `j = 1/j` gives `j = ±1`. -/
theorem self_inverse_cases (j : ℝ) (h0 : j ≠ 0) (h : j = 1 / j) :
    j = 1 ∨ j = -1 := by
  have h1 : j * j = 1 := by
    calc j * j = j * (1 / j) := by rw [← h]
      _ = 1 := mul_one_div_cancel h0
  exact mul_self_eq_one_iff.mp h1

/-- Under Mathlib's total convention `1/0 = 0`, `j = 0` also satisfies `j = 1/j`.
This is why the reciprocal convention has to be stated. -/
theorem zero_satisfies_totalized : (0 : ℝ) = 1 / 0 := by simp

-- The constant-jerk conclusion needs both the nonzero clause and continuity.
-- A smooth function with third derivative identically 1 is `fun t => t ^ 3 / 6`.
-- TODO(jerk): prove `iteratedDeriv 3 (fun t : ℝ => t ^ 3 / 6) = fun _ => 1`.

end CrookedPlatonism.Jerk
EOF

write_file CrookedPlatonism/Mathlib/TifuOrders.lean <<'EOF'
import Mathlib

/-!
# TifuOrders

Status: theorem.

Scope: the axiom `A x` says `x t ≠ 0` and `x t = 1 / x t` for all `t` (ordinary
partial reciprocal). If a function is constant, its derivative is zero, so `A`
fails for that derivative. This is the engine of the appendix result that
axioms for two different orders are jointly unsatisfiable.
-/

namespace CrookedPlatonism.TifuOrders

/-- The self-inversion axiom for a function `x`, with the nonzero clause. -/
def A (x : ℝ → ℝ) : Prop := ∀ t, x t ≠ 0 ∧ x t = 1 / x t

/-- The derivative of a constant function is the zero function. -/
theorem deriv_of_const (c : ℝ) : deriv (fun _ : ℝ => c) = fun _ => 0 := by
  funext t
  simp

/-- If `g` is constant, `A` fails for `deriv g`. -/
theorem not_A_deriv_of_const (c : ℝ) : ¬ A (deriv (fun _ : ℝ => c)) := by
  intro h
  have h0 := (h 0).1
  simp at h0

end CrookedPlatonism.TifuOrders
EOF

# ---------------------------------------------------------------- simulations

write_file simulations/README.md <<'EOF'
# Simulations

Numerical experiments live here. Convention: each script states its status
(definition, theorem, empirical, design rule, analogy, conjecture) in its
header and prints its own parameters, so a result can be rerun.

Planned:
- jerk_regress.py: the symmetry of the regress argument (any order works the same).
- ostrogradsky.py: instability for higher-derivative Lagrangians.
EOF

# -------------------------------------------------------------- optional move

if [ "$MOVE_UPSTREAM" = "1" ]; then
  mkdir -p upstream/docs
  for d in attempts simulations/What_If_Lean_Was_Different.md src; do
    if [ -e "$d" ]; then
      mkdir -p "upstream/$(dirname "$d")"
      git mv "$d" "upstream/$d" 2>/dev/null || mv "$d" "upstream/$d"
      echo "moved  $d -> upstream/$d"
    fi
  done
  for f in Ontological_Assumptions_of_Lean.md The_Death_of_ZFC.md Why_Lean_Fails.md; do
    if [ -e "docs/$f" ]; then
      git mv "docs/$f" "upstream/docs/$f" 2>/dev/null || mv "docs/$f" "upstream/docs/$f"
      echo "moved  docs/$f -> upstream/docs/$f"
    fi
  done
fi

echo
echo "Done. Next:"
echo "  lake build"
echo "Messages from the #print axioms lines appear during the build."
