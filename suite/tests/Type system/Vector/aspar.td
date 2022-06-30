/*** This file is part of Transd reference test suit.
	File:          aspar.td
	Created:       Вт, 21 июн 2022 13:57
	Last edited:   Thu, 30 Jun 2022 06:41

	Abstract: Passing vector as an argument to functions.
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

    // arg to FTFunc
    tst1: (λ (func [1,2,3])),

    // arg to FTMeth
    tst2: (λ locals: ob ClA([3,4,5])
        (meth ob [1,2,3])
    ),

    // arg to @init
    tst3: (λ (with ob ClA([3,4,5]))),

    _start: (λ 
        (tst1)
        (tst2)
        (tst3)

        (processRes "aspar" (str ss) check)
    )
}
