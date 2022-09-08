/***
 This file is part of the reference test suit of Transd programming language.
 File:          if.td
 Last edited:   Wed, 07 Sep 2022 13:20

 Abstract:  A basic test of 'if' form.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "3-53--35-3--5--FOUND",

    _start: (λ locals: v 49 z 2 fnd false
        (while (<= z v) (+= z 1) 
            (if (not (mod z 18)) (= fnd true) break
            elsif (not (mod z 5)) (textout to: ss "5")
            elsif (not (mod z 3)) (textout to: ss "3")
            else (textout to: ss "-")
        ))
        (textout to: ss (if fnd "FOUND" else "NOT FOUND"))
        (processRes "if" (str ss) check)
    )
}
