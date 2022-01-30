/*This file is a part of Tourbillon compiler test suit.

  Emulating recursion with closures.

*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


MainModule: {
import: "tests",
ss: StringStream(),
check: "120",

Lii: typealias(Lambda<Int Int>()),

b: Lii(),

makerec:(λ a Lii()
        (rebind b (λ [[a]] i Int() (ret (exec a i))))
        (ret a)),

fac_: Lii(λ i Int()  
        (if (> i 1) (ret (* i (exec b (- i 1))))) (ret 1) ),

_start: (λ
    (with fac (makerec fac_)
        (textout to: ss (exec fac 5))
    )

    (processRes "recursive" (str ss) check)
)
}
