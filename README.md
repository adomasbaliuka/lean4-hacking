# Lean 4 Hacking
[![.github/workflows/push.yml](https://github.com/adomasbaliuka/lean4-hacking/actions/workflows/push.yml/badge.svg)](https://github.com/adomasbaliuka/lean4-hacking/actions/workflows/push.yml)

# NOTE: THIS REPOSITORY IS NOT READY YET FOR PARTICIPATION IN THE GAME!

This repository is an attempt to set up CI such that proofs of False are rejected (by the Lean kernel.
There is no automation that "checks for the word `False`").

By circumventing some checks, it is probably still possible to prove `False`.

# Game Rules

If you find a way to prove False that passes the GitHub-Action CI, please submit a PR!
The CI will run on each commit in a PR.
Note that the project depends on [`Mathlib4`](https://github.com/leanprover-community/mathlib4), which you may use.

To win the game,
- Edit only the two files `Lean4Hacking/StatementOfFalse.lean` and `Lean4Hacking/ProofOfFalse.lean`. **Editing or adding any other files disqualifies the attempt!**
- After edits to `Lean4Hacking/StatementOfFalse.lean`, this file should not exceed 20 lines of code and also not exceed 500 bytes. This file is there to make it easy to judge if the attempt is valid. It should be hard or impossible to tell what loophole was used when looking only at this file.
- Feel free to **look** at the CI scripts and tools to get ideas what might work.
- Do your mischief in `Lean4Hacking/ProofOfFalse.lean`!
- **You win by submitting a PR that passes CI** where `Lean4Hacking/StatementOfFalse.lean` still contains the line `lemma statement_of_false : False := by` and the line is run.

**Please keep the number of commits reasonable!**

That's all you need to know!
Have fun!

# Already (hopefully) addressed loopholes

TODO
- Axioms
- Macros (e.g. redefining `False`)
