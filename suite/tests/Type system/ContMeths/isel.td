/***
    This file is a part of Transd reference test suit.

	File:          isel.td
	Created:       Mon, 16 May 2022 10:57
	Last edited:   Mon, 16 May 2022 11:06
	Abstract:      Test of 'is-el' container method.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "0 1 0 1 1 1",

    v: [6,0,2,8,3,7,4,1,5],
    s: "djahicebgf",
	_start: (λ 
        (textout to: ss (is-el v 9) " ")
        (textout to: ss (is-el v 2) " ")
        (textout to: ss (is-el s Char('k')) " ")
        (textout to: ss (is-el s Char('i')) " ")
        (textout to: ss (is-el [3,4,5] 3) " ")
        (textout to: ss (is-el "abc" Char('a')))

        (processRes "isel" (str ss) check)
    )
}
