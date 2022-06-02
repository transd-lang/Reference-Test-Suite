/*** This file is part of Transd reference test suit.
 File:          keyobject.td
 Created:       Tue, 31 May 2022 23:48
 Last edited:   Ср, 01 июн 2022 00:40
 Abstract:
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

class PT2 : {
	x : Double(),
	y : Double(),
	@init: (λ x_ Double() y_ Double() (set x x_) (set y y_)),
	@to-String: (λ ss StringStream() (textout to: ss "(" :fixed prec: 2 x "; " y ")" ) )
}


MainModule : {
    import: "tests",
    ss: StringStream(),
    check: "{(2.00; 3.00) : \"two-three\", (1.00; 2.00) : \"one-two\"}",
	i1 : HashIndex<PT2 String>(),
	_start: (λ
        (insert i1 PT2(1.0 2.0) "one-two")
        (insert i1 PT2(2.0 3.0) "two-three")
        (insert i1 PT2(2.0 3.0) "two-three1")
        (textout to: ss i1)

        (processRes "keyobject" (str ss) check)
    )
}
