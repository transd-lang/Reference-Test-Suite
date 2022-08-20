/***
 This file is part of the reference test suit of Transd programming language.
 File:          init.td
 Created:       Tue, 21 Jun 2022 13:57
 Last edited:   Sat, 06 Aug 2022 09:54

 Abstract: Series of tests (continued in initN.td files) covering a variety of cases of initializing vectors with data.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


public module Shared: {
    ss: StringStream()
}

class ClA: {
    import: "Shared",

    @init: (λ v Vector<Int>()
        (textout to: ss v " ")
    ),

    meth: (λ v Vector<Int>()
        (textout to: ss v " ")
    )
}

MainModule: {
    import: "tests",
    import: "Shared",

    check: "[1, 2, 3] [3, 4, 5] [1, 2, 3] [3, 4, 5] ",

    func: (λ v Vector<Int>() 
        (textout to: ss v " ")
    ),

    // passing value initializer to a function
    tst1: (λ (func [1,2,3])),

    // passing value initializer to an object's method
    tst2: (λ locals: ob ClA([3,4,5])
        (meth ob [1,2,3])
    ),

    // passing value initializer to an object's @init method
    tst3: (λ (with ob ClA([3,4,5]))),

    _start: (λ 
        (tst1)
        (tst2)
        (tst3)

        (processRes "init" (str ss) check)
    )
}
