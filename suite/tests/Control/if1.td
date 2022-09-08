/***
 This file is part of the reference test suit of Transd programming language.
 File:          if1.td
 Created:       Wed, 07 Sep 2022 13:20
 Last edited:   Wed, 07 Sep 2022 13:30

 Abstract: Issue #12: NR for (if) in recursive method calls.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

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
            (= lpar (+ mpar (meth2 (- cnt 1) (+ mpar a))))
            (ret lpar)
        )
        (if true (textout to: ss mpar " "))
        (-= mpar 2)
        (ret (exec la))
    ),
    meth1: (λ
        (meth2 5 10)
    )
}

MainModule: {
    import: "Shared",
    import: "tests",
    check: "10 11 12 13 14 60",
    _start: (λ locals: ob ClA(1)
        (textout to: ss (meth1 ob))
        (processRes "if1" (str ss) check)
    )
}
