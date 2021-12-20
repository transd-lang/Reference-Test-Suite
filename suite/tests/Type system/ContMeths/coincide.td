/*This file is a part of Tourbillon compiler test suit.

  Test of 'coincide' container method.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "430085100",

    vn: [0,1,2,3,4,5,6,7,8,9],
    vn1: [0,1,2,3,3,4,5,6,7,8,9],
    vn2: [0,1,2],
    vn3: [1,1,2],
    vn4: Vector<Int>(),
    vs: ["a", "b", "c", "d", "e", "f", "g", "h"],
    vs1: ["a", "b", "c", "d", "e", "f", "g", "h"],
    s: "abcdefgh",
    s1: "abcdeefgh",
    s2: "a",
    s3: "b",
    s4: "",
	_start: (λ 
        (textout to: ss (coincide vn vn1))
        (textout to: ss (coincide vn vn2))
        (textout to: ss (coincide vn2 vn3))
        (textout to: ss (coincide vn2 vn4))
        (textout to: ss (coincide vs vs1))
        (textout to: ss (coincide s s1))
        (textout to: ss (coincide s s2))
        (textout to: ss (coincide s3 s2))
        (textout to: ss (coincide s3 s4))

        (processRes "coincide" (str ss) check)
    )
}
