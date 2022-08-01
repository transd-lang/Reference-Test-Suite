/*** This file is part of Transd reference test suit.
	File:          meths.td
	Created:       Пт, 17 июн 2022 04:10
	Last edited:   Tue, 05 Jul 2022 15:58

	Abstract: Call to the same object's method using implicit
    call subject.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

class ClA: {
    // (meth2) call uses the implicit subject
    meth1: (λ i Int() (ret (+ (meth2 i) 5))),

    meth2: (λ i Int() (ret (+ i 7)))
}

MainModule : {
    import: "tests",
    check: "23",
    ss: StringStream(),
    ob: ClA(),

    tst1: (λ (textout to: ss (meth1 ob 11))),

	_start: (λ 
        (tst1)
        (processRes "meths" (str ss) check)
    )
}
