def from_false {P : Prop} (p : False) : P := False.elim p

def from_false_true_is_false (p : False) : True = False := False.elim p

def proof_of_true : True := True.intro

def false_implies_true : False → True := λ f => False.elim f

#check And

inductive Birds_chirping : Prop
| yep
| nope

inductive Sky_blue : Prop
| yep

theorem both_and : And Birds_chirping Sky_blue := And.intro Birds_chirping.nope Sky_blue.yep

theorem proof_equal : Birds_chirping.nope = Birds_chirping.yep :=
by trivial

theorem one_or_other : Or Birds_chirping Sky_blue := Or.inl Birds_chirping.yep

example : Or Birds_chirping (0 = 1) := Or.inl Birds_chirping.nope
example : (0 = 1) ∨ (1 = 2) := _

theorem or_comm {P Q : Prop} : P ∨ Q → Q ∨ P :=
λ f => match f with
  | Or.inl p => Or.inr p
  | Or.inr q => Or.inl q

def no (α : Type) := α → Empty

#check Not

inductive Raining : Prop

example : ¬ Raining := λ (r : Raining) => nomatch r
