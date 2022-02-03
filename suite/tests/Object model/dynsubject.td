/*This file is a part of Transd reference test suit.

  A combined test of class- and module-related features.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

public module Shared: {
    ss: StringStream()
}


private module MainModule: {
    import: "Shared",
    import: "Quad",
    import: "tests",
    check: "4.5 5.5 5.5 6.5 6.5 ",
    v: Vector<Quad>(),

    _start: (λ  
        (for i in Range(5 10) do
            (append v Quad( (to-Int i)))
            (meth1 (back v) 2.5)
        )

        (processRes "dynsubject" (str ss) check)
    )
}


class Quad: {
    import: "Shared",

    mem1: Int(),

    @init: (λ i Int() (set mem1 (/ i 2))),

    meth1: (λ x Double() 
        (textout to: ss (+ x (to-Double mem1) ) " ")
    )
}
