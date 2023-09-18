/-!
# Homework #3

The purpose of this homework is to strengthen your
understanding of function composition and of enumerated
and product data types. 

## Overview and Rules

The collaboration rule for this homework is that
you may *not* collaborate. You can ask friends and
colleagues to help you understand material in the
class notes, but you may not discuss any aspect
of this homework itself with anyone other than one
of the instructors or TAs. Why? Because *you* need
to learn this material to pass the exam to come.
-/

/-!
## Problem #1

Define a function of the following polymorphic type:
{α β γ : Type} → (β → γ) → (α → β) → (α → γ). Call it
*funkom*. After the implicit type arguments it should
take two function arguments and return a function as
a result. 
-/

-- Answer below

def funkom {α β γ : Type} : 
(β → γ) →
(α → β) → 
(α → γ)
|g, f => (fun a => g (f a))

#check funkom
/-! 
## Problem #2

Define a function of the following polymorphic type:
{α β : Type} → (a : α) → (b : β) → α × β. Call it mkop.
-/

-- Answer below
def mkop {α β : Type} : 
α → β → Prod α β
|a, b => Prod.mk a b



#check mkop


/-! 
## Problem #3

Define a function of the following polymorphic type:
{α β : Type} → α × β → α. Call it op_left.
-/

-- Answer below
def op_left {α β : Type} :
Prod α β → α
| Prod.mk a _ => a

#eval op_left (mkop "Hello" 1)
#check op_left
/-! 
## Problem #4

Define a function of the following polymorphic type:
{α β : Type} → α × β → β. Call it op_right.
-/

-- Answer below
def op_right {α β : Type} :
Prod α β → β
| Prod.mk _ b => b

#eval op_right (mkop "Hello" 1)
#check op_right
/-! 
## Problem #5

Define a data type called *Day*, the values of which
are the names of the seven days of the week: *sunday,
monday,* etc. 

Some days are work days and some days are play
days. Define a data type, *kind*, with two values,
*work* and *play*.

Now define a function, *day2kind*, that takes a *day*
as an argument and returns the *kind* of day it is as
a result. Specify *day2kind* so that weekdays (monday
through friday) are *work* days and weekend days are
*play* days.

Next, define a data type, *reward*, with two values,
*money* and *health*.

Now define a function, *kind2reward*, from *kind* to 
*reward* where *reward work* is *money* and *reward play* 
is *health*.

Finally, use your *funkom* function to produce a new
function that takes a day and returns the corresponding
reward. Call it *day2reward*.

Include test cases using #reduce to show that the reward
from each weekday is *money* and the reward from a weekend
day is *health*.
-/
namespace Problem5

inductive Day : Type
| sunday
| monday
| tuesday
| wednesday
| thursday
| friday
| saturday

open Day

inductive Kind : Type
| work
| play

open Kind

def day2kind : Day → Kind
| sunday => play
| monday => work
| tuesday => work
| wednesday => work
| thursday => work
| friday => work
| saturday => play

inductive Reward : Type
| money
| health

open Reward

def kind2reward : Kind → Reward
| work => money
| play => health

def day2reward : Day → Reward
| a => funkom kind2reward day2kind a

#reduce day2reward sunday --expect health
#reduce day2reward monday --expect money

end Problem5
/-!
## Problem #6

### A. 
Consider the outputs of the following #check commands. 
-/

#check Nat × Nat × Nat
#check Nat × (Nat × Nat)
#check (Nat × Nat) × Nat

/-!
Is × left associative or right associative? Briefly explain
how you reached your answer.

Answer here: Right associative, since putting the parentheses
on the right did not change the type.

### B.
Define a function, *triple*, of the following type:
{ α β γ : Type } → α → β → γ → (α × β × γ)  
-/

-- Here:
def triple {α β γ : Type} : α → β → γ → α × β × γ 
|a, b, c => Prod.mk a (Prod.mk b c)

/-!
### C.
Define three functions, call them *first*, *second*, 
and *third*, each of which takes any such triple as
an argument and that returns, respectively, its first,
second, or third elements.
-/

-- Here:
def first {α β γ : Type} :
α × β × γ → α
| Prod.mk a (Prod.mk _ _) => a

def second {α β γ : Type} :
α × β × γ → β
| Prod.mk _ (Prod.mk b _) => b

def third {α β γ : Type} :
α × β × γ → γ
| Prod.mk _ (Prod.mk _ g) => g
/-!
### D.
Write three test cases using #eval to show that when 
you apply each of these "elimination" functions to a
triple (that you can make up) it returns the correct
element of that triple.  
-/

-- Here:

def set1 := triple 1 2 3
#eval set1 -- expect (1, 2, 3)

def set2 := triple "Hello" true 5
#eval set2 -- expect ("Hello", true, 5)

#eval first set2 -- expect "Hello"
#eval second set2 -- expect true
#eval third set2 -- expect 5
/-!
### E.
Use #check to check the type of a term. that you make 
up, of type (Nat × String) × Bool. The challenge here
is to write a term of that type. 
-/

def weird_product : Nat → String → Bool → (Nat × String) × Bool
|n, s, b => Prod.mk (Prod.mk n s) b

#check weird_product




