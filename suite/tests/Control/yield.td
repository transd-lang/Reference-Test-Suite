/*** This file is a part of Transd reference test suit.
 File:          yield.td
 Created:       Wed, 18 May 2022 10:49
 Last edited:   Wed, 18 May 2022 10:52
 Abstract:      Test of 'yield' instruction.
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
