/*This file is a part of Tourbillon compiler test suit.

  A combined test of class- and module-related features.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }


public module Export: {
	expVar: 50,
    expVar1: 14,
    ss: StringStream()
}

private module MainModule: {
    import: "Export::expVar",
    import: "Export::ss",
    import: "Util",
    import: "tests",
    check: "x: 5.5 mem1: 114",
    succ: false,

    _start: (λ  
        (shade 3.0)
        (processRes "import1" (str ss) check)
    )
}


public module Util: {
    import: "Export::ss",
    import: "Export::expVar1",

    mem1: Int(),

    @init: (λ (set mem1 100)),

    shade: (λ x Double() 
        (textout to: ss "x: " (+ x 2.5) " mem1: " (+ mem1 Export::expVar1) )
    )
}
