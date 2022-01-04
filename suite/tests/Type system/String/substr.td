/*This file is a part of Tourbillon compiler test suit.

    Test of '(substr)' method.

*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: 
"abcd 16",
    
    _start: (λ 
        (with s "abcd:16"
            (with fi (substr s 0 ":") se (substr s after: ":" )
                (textout to: ss fi " " se)
            )
        )

        (processRes "string_substr" (str ss) check)
    )
}
