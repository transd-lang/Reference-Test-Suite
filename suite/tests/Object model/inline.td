/***
 This file is part of the reference test suit of Transd programming language.
 File:          inline.td
 Created:       Tue, 14 Jun 2022 13:11
 Last edited:   Wed, 03 Aug 2022 11:33
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
