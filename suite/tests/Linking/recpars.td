/* This file is a part of Transd reference test suit.

  CHECK: recursive evaluation of function parameters and local variables.*/
#lang transd


Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule : {
import: "tests",
check:"false true true false true",
ss: StringStream(),
b1: false,
b2: Bool(true),
s1: "false",

func1: (λ a Int() b (+ a 1) (texout "a: " a "; b: " b)
),

_start: (λ 
(with b3 true b4 Bool(false) b5 Bool(s1) (textout to: ss :boolalpha 
    b1 " " b2 " "  b3 " " b4 " " b5))
    (processRes "simple" (str ss) check)
)
}
