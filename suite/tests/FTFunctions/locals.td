/*** 
 This file is part of the reference test suit of Transd programming language.
 File:          locals.td
 Created:       Sun, 03 Jul 2022 09:17
 Last edited:   Tue, 02 Aug 2022 02:47
 Abstract: Initialization of local variales.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule : {
import: "tests",
ss: StringStream(),
idx1: Index<Int Int>({1:101,2:102,3:103,4:104}),

// test 1: initialized and not initialized locals
tst1: (λ locals: loc1 String() loc2 2
    (if (and (not (is-def loc1)) (eq loc2 2)) 
        (= loc1 "a") (= loc2 5) (ret "1"))
    (ret "0")
),

// test 2: initializing local container objects using parameters
tst2: (λ p Int() locals: 
    v Vector<Int>([p])
    i Index<Int String>({p:"one"})
    ss StringStream()
    (textout to: ss "p: " p ", v: " v ", i: " i)
    (if (eq (str ss) "p: 5, v: [5], i: {5 : \"one\"}")
        (ret "1"))
    (lout (str ss)) (ret "0")
),

// test 3: using parameters as arguments to the locals' initializers
tst3: (λ i Int() locals: a (get-val idx1 i 0)
    ss StringStream()
    (textout to: ss "a: " a)
    (if (eq (str ss) "a: 103")
        (ret "1"))
    (lout (str ss)) (ret "0")
),

_start: (λ 
    (with check "1 1 1 1"
        (textout to: ss (tst1) " ")
        // call for the second time to check that locals
        // are in fresh state at every call
        (textout to: ss (tst1) " ")
        (textout to: ss (tst2 5) " ")
        (textout to: ss (tst3 3))

        (processRes "locals" (str ss) check)
    )
)
}
