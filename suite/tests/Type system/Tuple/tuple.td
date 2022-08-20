/***
 This file is part of the reference test suit of Transd programming language.
 File:          tuple.td
 Created:       Wed, 26 Jan 2022 11:57
 Last edited:   Fri, 19 Aug 2022 21:40

 Abstract: Tuple.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "abcd",
    tp : [[12, "ab", 34, "cd"]],

    concatStr: (λ l String() r String() (ret (+ l r))),
    
    _start: (λ 
        (textout to: ss (concatStr (get tp 1) (get tp 3)))

        (processRes "tuple" (str ss) check)
    )
}
