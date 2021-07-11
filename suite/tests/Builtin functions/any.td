/*This file is a part of Tourbillon compiler test suit.

  Test of (any ...) function.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }



private module MainModule: {
    import: "tests",
    check: "true false true",
    ss: StringStream(),

    _start: (λ  
        (with v [0,10,15,20,25,30]
            (textout to: ss (any v) " ")
            (textout to: ss (any v (λ (mod @it 5))) " ")
            (set-el v 5 (+ (get v 5) 1))
            (textout to: ss (any v (λ (mod @it 5))))
        )
        (processRes "any" (str ss) check)
    )
}

