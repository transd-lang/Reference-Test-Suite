/***
 This file is part of the reference test suit of Transd programming language.
 File:          init2.td
 Created:       Fri, 26 Aug 2022 22:55
 Last edited:   Fri, 26 Aug 2022 23:02
 Abstract:
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
    la Lambda<Int Int>(λ par Int()
        (lout to: ss "in la: p: " par)
        (ret (* par par))
    )
    (textout to: ss (exec la par))
),

meth1: (λ
    (meth2 5)
)
}

MainModule: {
import: "tests",
import: "Shared",
check:
"in la: p: 5
25",
 _start: (λ locals: ob ClA(1)
    (meth1 ob)
    (processRes "init2" (str ss) check)
)
}
