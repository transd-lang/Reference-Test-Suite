/***
 This file is part of the reference test suit of Transd programming language.
 File:          any.td
 Created:       Tue, 18 Jan 2022 10:49
 Last edited:   Sun, 06 Nov 2022 15:54
 Abstract:      Test of '(any ...)' built-in form.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }



private module MainModule: {
    import: "tests",
    
    tst1: (λ locals: ss StringStream()
        (with v [0,10,15,20,25,30]
            (textout to: ss :boolalpha (any v) " ")
            (textout to: ss (any v (λ (mod @it 5))) " ")
            (set-el v 5 (+ (get v 5) 1))
            (textout to: ss (any v (λ (mod @it 5))))
        )

        (if (neq (str ss) "true false true") (throw (+ "tst1: " (str ss))))
    ),

    tst2: (λ locals: ss StringStream() s "ABCDEF"
        (textout to: ss (any (for c in "GHIJK" project (is-el s c))) " ")
        (textout to: ss (any (for c in "GHIEJK" project (is-el s c))))
        (if (neq (str ss) "0 1") (throw (+ "tst2: " (str ss))))
    ),

    _start: (λ locals: check "OK"
        (try (tst1) (tst2)
        (catch (= check (str @ex))))
        (processRes "any" check "OK")
    )
}

