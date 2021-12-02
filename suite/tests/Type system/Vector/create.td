/*This file is a part of Tourbillon compiler test suit.

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
