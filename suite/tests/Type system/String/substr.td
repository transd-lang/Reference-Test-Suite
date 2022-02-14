/*This file is a part of Transd reference test suit.

    Test of '(substr)' method.

*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: 
"abcd 16 d:",
    
    _start: (λ 
        (with s "abcd:16"
            (with fi (substr s 0 ":") se (substr s after: ":" )
                (textout to: ss fi " " se " ")
            )
            (with fi (substr s from: before: ":" to: before: "6")
                (textout to: ss fi )
            )
        )

        (processRes "string_substr" (str ss) check)
    )
}
