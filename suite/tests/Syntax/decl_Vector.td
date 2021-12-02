/*This file is a part of Tourbillon compiler test suit.

  CHECK: all forms of variable declarations work correctly.*/
#lang transd


Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule : {
    import: "tests",
    check: "false
[1, 2, 3]
[1, 2, 3]
[1, 2, 3]
[1, 2, 3]
[1, 2, 3]
",
    ss: StringStream(),
    v1: Vector<Int>(),
    v2: Vector<Int>( 3 ),
    v3: Vector<Int>([1,2,3]),
    a: 1,
    b: 2,
	_start: (λ 
        (with res (fst (eval "(with v Vector())"))
            (textout to: ss res "\n")
        )
        (append v1 1) (append v1 2) (append v1 3)
        (set-el v2 0 1)(set-el v2 1 2)(set-el v2 2 3)
        (with v4 Vector<Int>([1,2,3]) v5 Vector<Int>([a,b,(+ a b)])
            (textout to: ss v1 "\n")
            (textout to: ss v2 "\n")
            (textout to: ss v3 "\n")
            (textout to: ss v4 "\n")
            (textout to: ss v5 "\n")
        )
        (processRes "decl_Vector" (str ss) check)
    )
}
