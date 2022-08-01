/*** This file is a part of Transd reference test suit.
 File:          class.td
 Created:       Sat, 30 Jul 2022 03:27
 Last edited:   Sat, 30 Jul 2022 04:02

 Abstract: Check that all meths and refs in a new object
 have correct subjects and roots.

 Spec: NR/spec_21
*/
#lang transd


Require : { searchDirs: ["../.."], packages: ["tests"] }

public module Shared: {
ss: StringStream()
}

public class ClA: {
    import: "Shared",
    v: Vector<Int>(),
    n: 37,
    @init: (λ i Int() (= n i)),
    meth3: (λ (append v n) (ret n)),
    methin: (λ 
        (append v (meth3))
        (append v n)
        (lout to: ss "mi: " v)
    ),
    methout: (λ 
        (append v (+ 3 (meth3)))
        (append v (+ 3 n))
        (methin)
        (lout to: ss "mo: " v)
    )
}

MainModule : {
import: "tests",
import: "Shared",
check:
"107
mi: [107, 110, 110, 107, 107, 107]
mo: [107, 110, 110, 107, 107, 107]
st: [107, 110, 110, 107, 107, 107]
",

_start: (λ 
    locals: ob ClA(107)
    (lout to: ss ob.n)
    (methout ob)
    (lout to: ss "st: " ob.v)
    (processRes "class" (str ss) check)
)
}
