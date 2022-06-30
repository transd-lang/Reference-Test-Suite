/*** This file is a part of Transd reference test suit.
 File:          inline.td
 Created:       Tue, 14 Jun 2022 13:11
 Last edited:   Вт, 14 июн 2022 14:13
 Abstract: Creation of inline objects
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
    check: "x: 20",
    ss: StringStream(),
	
    _start: (λ 
        (textout to: ss ClA((+ 25 (- a))))

        (processRes "inline" (str ss) check)
    )
}
