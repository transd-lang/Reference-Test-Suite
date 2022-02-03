/*This file is a part of Transd reference test suit.

  Test of (first) function.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }



private module MainModule: {
    import: "tests",
    check: "bcd 10",
    ss: StringStream(),

    _start: (λ  
        (with s "abcd"
            (textout to: ss (first (substr s "e") (substr s after: "a")) " ")
            (textout to: ss (first (substr s "e") "10"))
        )
        (processRes "first" (str ss) check)
    )
}

