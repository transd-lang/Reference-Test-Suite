/*This file is a part of Transd reference test suit.

  CHECK: compound type function parameters.*/
#lang transd


Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule : {
    import: "tests",
    check:"[1, 2, 3]",
ss: StringStream(),

    i1: Index<String Vector<Int>>({"item1":[1,2,3]}),
    func1: (λ ind Index<String Vector<Int>>()
        (textout to: ss (snd (get ind "item1")))
    ),
	_start: (λ 
        (func1 i1)
        (processRes "funcpars" (str ss) check)
    )
}
