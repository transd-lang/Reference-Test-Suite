/*This file is a part of Tourbillon compiler test suit.

  String construction.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "abc def",
    succ: false,
    s: String("abc " 
"def"),
    
    _start: (λ 
        (textout to: ss s)

        (processRes "string_create" (str ss) check)
    )
}
