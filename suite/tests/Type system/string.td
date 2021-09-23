/*This file is a part of Tourbillon compiler test suit.

  String built-in type operations.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: 
"test string
a \"qqq\" b",
    
    _start: (λ 
        (textout to: ss String("test " "string\n"))
        (with s "qqq"
            (textout to: ss String("a \"" s "\" b"))
        )

        (processRes "string" (str ss) check)
    )
}
