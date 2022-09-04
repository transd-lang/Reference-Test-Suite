/***
 This file is part of the reference test suit of Transd programming language.
 File:          any.td
 Created:       Tue, 18 Jan 2022 10:49
 Last edited:   Mon, 22 Aug 2022 06:51
 Abstract:      Test of '(any ...)' built-in form.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }



private module MainModule: {
    import: "tests",
    check: "1 1",
    ss: StringStream(),
    
    tst1: (λ locals: ss StringStream()
        (with v [0,10,15,20,25,30]
            (textout to: ss :boolalpha (any v) " ")
            (textout to: ss (any v (λ (mod @it 5))) " ")
            (set-el v 5 (+ (get v 5) 1))
            (textout to: ss (any v (λ (mod @it 5))))
        )

        (if (eq (str ss) "true false true") (ret "1") else (ret (str ss)))
    ),

    tst2: (λ locals: ss StringStream() s "ABCDEF"
        (textout to: ss (any (for c in "GHIJK" project (is-el s c))) " ")
        (textout to: ss (any (for c in "GHIEJK" project (is-el s c))))
        (if (eq (str ss) "0 1") (ret "1") else (ret (str ss)))
    ),

    _start: (λ  
        (textout to: ss (tst1) " ")
        (textout to: ss (tst2))
        (processRes "any" (str ss) check)
    )
}

