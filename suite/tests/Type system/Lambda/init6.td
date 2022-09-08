/***
 This file is part of the reference test suit of Transd programming language.
 File:          init6.td
 Created:       Tue, 06 Sep 2022 10:06
 Last edited:   Wed, 07 Sep 2022 02:35
 Abstract: Captures in recursive calls of local lambdas.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


public module Shared: {
    ss: StringStream()
}

class ClA: {
    import: "Shared",
    a: Int(),
    @init: (λ i Int() (= a i)),
    meth2: (λ cnt Int() mpar Int()
        locals: 
        la Lambda<Null Int>(λ [[cnt, mpar]] 
            locals: lpar 0
            (if (== cnt 1) (ret mpar))
            (textout to: ss mpar " ")
            (= lpar (+ mpar (meth2 (- cnt 1) (+ mpar a))))
            (ret lpar)
        )
        (-= mpar 2) // shouldn't change the captured mpar
        (ret (exec la))
    ),
    meth1: (λ
        (meth2 5 10)
    )
}

MainModule: {
    import: "tests",
    import: "Shared",
    check: "10 11 12 13 60",

    _start: (λ locals: ob ClA(1)
        (textout to: ss (meth1 ob))
        (processRes "init6" (str ss) check)
    )
}
