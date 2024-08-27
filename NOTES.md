# Notes on ways to "prove" `False`

These notes try to list possible pitfalls that the CI has to catch and try to document how this is done.
Some of the options how this might happen could be relevant for [this prediction market](https://manifold.markets/tfae/is-the-lean-kernel-unsound) so it's good to keep track of.

## Axioms

A user might define any axioms they please, including inconsistent ones. The CI must check what axioms the definition depends on and reject if there are any non-standard ones.


### `Lean.ofReduceBool`

is a language-defined axiom that comes with definitions that trust the compiler (as opposed to only the kernel).
One should expect it to be possible to prove `False` when this axiom is allowed.
An [example](https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/.E2.9C.94.20.23eval.20optimization.20bug.3F/near/441368912) (that has since been fixed):
```lean
def a := (123456789012345678901).toUInt64        -- 12776324570088369205
def b := (123456789012345678901).toUInt64.toNat  -- 123456789012345678901

theorem a_eq : a = 12776324570088369205 := rfl

theorem b_eq : b = 123456789012345678901 := by native_decide

theorem a_eq_b : a.toNat = b := rfl

theorem a_neq_b : a.toNat ≠ b := by simp [a_eq, b_eq]

theorem false : False := a_neq_b a_eq_b

theorem flt (a b c n : Nat) : (a + 1) ^ (n + 3) + (b + 1) ^ (n + 3) ≠ (c + 1) ^ (n + 3) :=
  false.elim
```

TODO decide if game should allow this axiom

## "Real world leakage"

Example from [Zulip](https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/soundness.20bug.3A.20native_decide.20leakage/near/395967589)

```lean
def foo : Bool :=
  match IO.getRandomBytes 1 () with
  | .ok bs _ => bs[0]! >= 128
  | _ => false
theorem T1 : false = Lean.reduceBool foo := rfl
theorem T2 : Lean.reduceBool foo = true := rfl
theorem contradiction : False := nomatch T1.trans T2
#print axioms contradiction
-- 'contradiction' does not depend on any axioms
```

not sure how to rule this out. TODO

This now depends on the axiom `Lean.trustCompiler`, so I guess it would be ruled out.
Maybe there are other examples that would not be.

## Metaprogramming ("macros")

Metaprogramming constructs (parsers, macros, elaborators) can be important from other files and could arbitrarily change the meaning of any code. Not sure yet how to rule this out.

## Environment hacking

There are ways to add definitions to the environment without having the kernel check them.
[Lean4checker](https://github.com/leanprover/lean4checker) should rule this out.

External checkers (which are planned to be used here) should also rule this out.


## ...

- https://github.com/leanprover/lean4/issues/188
