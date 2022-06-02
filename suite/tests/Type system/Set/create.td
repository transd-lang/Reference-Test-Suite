/*** This file is part of Transd reference test suit.
	File:          create.td
	Created:       Сб, 28 май 2022 11:26
	Last edited:   Сб, 28 май 2022 11:56
	Abstract: Creation of Set objects.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: 
    "[3, 17, 25, 99]
[\"aaa\", \"awr\", \"baa\", \"qwr\", \"sqj\", \"zbc\"]",
    a: Set<Int>(),
    b: Set<String>(),

    _start: (λ 
        (insert a 25)(insert a 3) (insert a 99)(insert a 17)(insert a 3)
        (insert b "zbc") (insert b "qwr") (insert b "awr")
        (insert b "aaa") (insert b "baa") (insert b "sqj")
        (textout to: ss a "\n") 
        (textout to: ss b) 

        (processRes "set_create" (str ss) check)
    )
}
