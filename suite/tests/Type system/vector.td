/*This file is a part of Tourbillon compiler test suit.

  Vector operations.
  Testing various methods of vector construction and
  'ret' form.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

/*
AssemblyDescription : {
    entryPoint : "vector::_start"
}*/

vector: {
    import: "tests",
    v: Vector( Int() ),
    a: 5,
    b: 6,
    ss: StringStream(),
    check: "[1, 2] [1, 2] [5, 2, 6]",
    succ: false,
    
	func: (λ a Int() b Int() -> Vector( Int() ) (ret [a, b])),

    func1: (λ (with v [a, 2, b]  (textout to ss v))),

    _start: (λ 
        (if verbose (textout " Testing 'vector'..." ))

        (add v 1)
        (add v 2)

        (textout to ss v " ")
        (textout to ss (func 1 2) " ")
        (func1) 

        (if (eq check (str ss)) (set succ true) (+= oktests 1)
        else (+= failtests 1))
        (textout (if succ (if verbose " OK\n" else ".")
            else String("\n  'vector' FAILED: " ss "\n")
            ))
    )
}
