/*** This file is part of Transd reference test suit.
 File:          recurs.td
 Created:       Tue, 14 Jun 2022 22:40
 Last edited:   Пт, 17 июн 2022 04:12
 Abstract:      Testing a class having a method returning a new object
                of that class.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

class ClA: {
    x: Int(0),

    @init: (λ i Int() (= x i)),

    @to-String: (λ ss StringStream() 
        (textout to: ss "x: " x)),

    create: (λ p Int()
        (ret ClA( p ))
    )
}

MainModule : {
    import: "tests",
    check: "x: 5",
    ss: StringStream(),
    ob: ClA(),

    tst1: (λ (textout to: ss (create ob 5))),

	_start: (λ 
        (tst1)
        (processRes "recurs" (str ss) check)
    )
}
