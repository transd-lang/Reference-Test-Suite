/*This file is a part of Tourbillon compiler test suit.

  CHECK: all forms of variable declarations work correctly.*/
#lang transd


Require : { searchDirs: ["../.."], packages: ["tests"] }

decl_Vector : {
    import: "tests",
    check: "01",
    ss: StringStream(),
	_start: (λ 
        (if verbose (textout " Testing 'decl'..." ))

        (with res (eval "(with v Vector())")
            (textout to: ss res)
        )
        (with res (eval "(with v Vector<Int>())")
            (textout to: ss res)
        )
        (processRes "decl" check (str ss))
    )
}
