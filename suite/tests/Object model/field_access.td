/*This file is a part of Transd reference test suit.

  Acessing fields in a dynamic subject with 'getf' method.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

class ClA: {
    a: Int(),

	access allow: {	a: [_] }
}

MainModule : {
    import: "ClA",
    import: "tests",
    i: 5,
    v: Vector<ClA>(2),
    check: "5 6",
    ss: StringStream(),

    f1: (λ p ClA() num Int() (= p.a (+ i num))),

	_start: (λ (for i in [0,1] do (f1 (get v i) i))
        (textout to: ss (getf (get v 0) "a") " " (getf (get v 1) "a")) 
        
        (processRes "field_access" (str ss) check)
    )
}

