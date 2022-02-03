/*This file is a part of Transd reference test suit.

  Test of 'find-adjacent' container method.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "--4g--a",
    v: [0,1,2,3,4,5,6,7,8,9],
    v1: ["a", "b", "c", "d", "e", "f", "g", "g"],
    s1: "abcdefgh",
	_start: (λ 
        (with pos (find-adjacent v)
            (if (neq pos (end v)) (textout to: ss (get-el pos))
            else (textout to: ss "--"))
            (set-el v 5 4)
            (= pos (find-adjacent v))
            (if (neq pos (end v)) (textout to: ss (get-el pos))
            else (textout to: ss "--"))
        )
        (with pos (find-adjacent v1)
            (if (neq pos (end v1)) (textout to: ss (get-el pos))
            else (textout to: ss "--")))
        (with pos (find-adjacent s1)
            (if (neq pos (end s1)) (textout to: ss (get-el pos))
            else (textout to: ss "--"))
            (set-el s1 1 "a")
            (= pos (find-adjacent s1))
            (if (neq pos (end s1)) (textout to: ss (get-el pos))
            else (textout to: ss "--"))
        )

        (processRes "find-adjacent" (str ss) check)
    )
}
