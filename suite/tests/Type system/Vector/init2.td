/***
 This file is part of the reference test suit of Transd programming language.
 File:          init2.td
 Created:       Sun, 07 Aug 2022 11:36
 Last edited:   Вс, 07 авг 2022 12:04

 Abstract: Continuation of tests of initializing vectors with data.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


MainModule: {
import: "tests",

a: 1, b: 2, c: 3,
ind: Index<String Vector<Int>>(),

tst1: (λ a Int() locals: ss StringStream() check
"10 12 26 "
    (set-el ind "A" [a, (+ a b), (* b (+ a c))])
        
    (for d in (get ind "A") do
        (textout to: ss d " "))

    (if (eq (str ss) check) (ret "1"))
        (lout (str ss)) (ret "0")
),

_start: (λ (with check "1" ss StringStream()
    (textout to: ss (tst1 10))

    (processRes "init2" (str ss) check)
)
)
}
