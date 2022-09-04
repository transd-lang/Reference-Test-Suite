/***
 This file is part of the reference test suit of Transd programming language.
 File:          init1.td
 Created:       Fri, 26 Aug 2022 22:46
 Last edited:   Fri, 26 Aug 2022 22:56
 Abstract: Continuation of lambda initialization tests.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

class ClA: {
meth: (λ m Int() pos Vector<Int>()
    locals: v Vector<Int>(pos) _sc 1
    (append v m)
    (tql v reduce: ["col1"] using: (λ i Int() (*= _sc i)))
    (+= (back v) _sc)
    (ret v)
),

la: Lambda<Vector<Int> Int Vector<Int>>(λ pos Vector<Int>() dep Int()
    (if (not dep) (ret pos))
    (for m in [6,8,4,9,2,3,5,1] do 
        (yield (exec la (meth m pos) (- dep 1)))
    )
)
}

MainModule: {
import: "tests",
ss: StringStream(),
check: "[12, 78] [12, 104] [12, 52] ",


_start: (λ locals: v Vector<Int>() ob ClA()
    (for i in Range(3) do
        (= v (exec ob.la v 2))
        (textout to: ss v " ")
    )
    (processRes "init1" (str ss) check)
)
}
