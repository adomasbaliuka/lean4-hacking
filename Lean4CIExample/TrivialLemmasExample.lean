/-
Copyright (c) 2024 Adomas Baliuka. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Adomas Baliuka
-/
import Mathlib
import Lean4CIExample.ExampleSubdir.ExampleInsideSubdir

lemma something_trivial : 2 + 2 = 4 := rfl

def add_one (n : Nat) : Nat := n + 1

#check Real.log_abs

def hello := "world"

lemma add_one_1_eq_2 : add_one 1 = 2 := by
  unfold add_one
  rfl

#guard fun_in_subdir 5 = 45
