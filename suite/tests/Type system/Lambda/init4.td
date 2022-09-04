/***
 This file is part of the reference test suit of Transd programming language.
 File:          init4.td
 Created:       Sun, 04 Sep 2022 14:26
 Last edited:   Sun, 04 Sep 2022 14:38
 Abstract: Issue #10: correct resolving of parent object's fields in
 local lambdas.
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
    meth2: (λ par Int()
        locals: 
        la Lambda<Int>(λ [[par]]
            (textout to: ss a " ")
            (ret (+ a par))
        )
        (textout to: ss a " ")
        (ret (exec la))
    ),
    meth1: (λ
        (textout to: ss a " ")
        (meth2 29)
    )
}

MainModule: {
    import: "tests",
    import: "Shared",
    check: "9 9 9 38",

    _start: (λ locals: ob ClA(9)
        (textout to: ss (meth1 ob))
        (processRes "init4" (str ss) check)
    )
}
