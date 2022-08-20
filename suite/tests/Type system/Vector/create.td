/*
 This file is part of the reference test suit of Transd programming language.
 File:          create.td
 Created:       Wed, 03 Aug 2022 11:57
 Last edited:   Wed, 03 Aug 2022 12:08

 Abstract: Continuation of tests of initializing vectors with data.

  Vector operations.
  Testing various methods of vector construction and
  'ret' form.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    v: Vector<Int>(),
    a: 5,
    b: 6,
    ss: StringStream(),
    check: "[1, 2] [1, 2] [5, 2, 6]",
    
	func: (λ a Int() b Int() -> Vector<Int>() (ret [a, b])),

    func1: (λ (with v [a, 2, b]  (textout to: ss v))),

    _start: (λ 
        (append v 1)
        (append v 2)
        (textout to: ss v " ")
        (textout to: ss (func 1 2) " ")
        (func1) 

        (processRes "vector" (str ss) check)
    )
}
