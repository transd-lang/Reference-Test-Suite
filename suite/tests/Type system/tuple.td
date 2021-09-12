/*This file is a part of Tourbillon compiler test suit.

  Tuple compound type.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

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
