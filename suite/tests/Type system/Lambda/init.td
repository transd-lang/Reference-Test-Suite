/***
 This file is part of the reference test suit of Transd programming language.
 File:          init.td
 Created:       Fri, 26 Aug 2022 22:28
 Last edited:   Fri, 26 Aug 2022 22:45

 Abstract: Series of tests (continued in other init*.td files) for
 testing initializating and using lambda objects in various contexts.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
import: "tests",
ss: StringStream(),
check: "[12, 78] [12, 104] [12, 52] ",

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
),

_start: (λ locals: v Vector<Int>()
    (for i in Range(3) do
        (= v (exec la v 2))
        (textout to: ss v " ")
    )
    (processRes "init" (str ss) check)
)
}
