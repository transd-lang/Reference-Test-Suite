/*This file is a part of Tourbillon compiler test suit.

  Test of 'is-subset' container method.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "true false true false ",

    v: [6,9,0,2,8,3,7,4,1,5],
    v1: [9,4,2],
    v2: [9,4,2,2],
    s: "djahicebgf",
    s1: "geb",
    s2: "gebb",
	_start: (λ 
           (sort v) (sort v1) (sort v2)
        (textout to: ss :boolalpha (is-subset v v1) " ")
        (textout to: ss (is-subset v v2) " ")
           (sort s) (sort s1) (sort s2)
        (textout to: ss (is-subset s s1) " ")
        (textout to: ss (is-subset s s2) " ")

        (processRes "issubset" (str ss) check)
    )
}
