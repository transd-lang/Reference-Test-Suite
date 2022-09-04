/***
 This file is part of the reference test suit of Transd programming language.
 File:          init3.td
 Created:       Sat, 27 Aug 2022 04:16
 Last edited:   Sat, 27 Aug 2022 05:13
 Abstract:  Issue #8: recursive call from locally defined lambda
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


class ClA: {
a: Int(),
@init: (λ i Int() (= a i)),
meth2: (λ par Int()
    locals: 
    la Lambda<Int Int>(λ par Int()
        (if (== par 1) (ret par))
        (ret (* par (meth2 (- par 1))))
    )
    (ret (exec la par))
),
meth1: (λ
    (meth2 5)
)
}

MainModule: {
import: "tests",
ss: StringStream(),
check: "120",

_start: (λ locals: ob ClA(1)
    (textout to: ss (meth1 ob))
    (processRes "init3" (str ss) check)
)
}
