/*This file is a part of Tourbillon compiler test suit.

  String built-in type operations.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "test string",
    succ: false,
    
    _start: (λ 
        (textout to: ss String("test " "string"))

        (processRes "string" (str ss) check)
    )
}
