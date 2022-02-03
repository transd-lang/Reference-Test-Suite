/*This file is a part of Transd reference test suit.

  A combined test of class- and module-related features.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }


public module Export: {
	expVar: 50,
    ss: StringStream()
}

private module MainModule: {
    import: "Export",
    import: "Quad",
    import: "tests",
    check: "x: 5.5 mem1: 25",
    succ: false,

    _start: (λ  
        (with quad Quad( expVar ) n 0
            (shade quad (to-Double (+ n 3)))
        )
        (processRes "ftnew" (str ss) check)
    )
}


class Quad: {
    import: "Export",

    mem1: Int(),

    @init: (λ i Int() (set mem1 (/ i 2))),

    shade: (λ x Double() 
        (textout to: ss "x: " (+ x 2.5) " mem1: " mem1 )
    )
}
