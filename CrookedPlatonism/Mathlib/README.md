# Mathlib experiments

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

These files build under Lean 4.34.1 with Mathlib v4.34.1.
