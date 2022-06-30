/***
 File:          create.td
 Created:       Sat, 25 Jun 2022 17:45
 Last edited:   Вс, 26 июн 2022 02:32

 Abstract: Creation of objects.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

class ClA: {
    x: Int(),
    @init: (λ i Int() (= x i)),
    @to-String: (λ ss StringStream() 
        (textout to: ss "x: " x))
}

MainModule : {
    import: "tests",
    a: 5,
    check: "x: 20 x: 20",
    ss: StringStream(),

    tst1: (λ
        (textout to: ss ClA((+ 25 (- a))) " ")
    ),

    tst2: (λ locals: ob ClA((+ 25 (- a)))
        (textout to: ss ob)
    ),
	
    _start: (λ 
        (tst1)
        (tst2)
        (processRes "create" (str ss) check)
    )
}
