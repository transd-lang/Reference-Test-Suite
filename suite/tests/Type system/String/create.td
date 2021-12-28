/*This file is a part of Tourbillon compiler test suit.

  String construction and initialization.

*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "abc def BCD ABC BCD ",
    succ: false,
    s: String("abc " 
"def"),
    
    _start: (λ 
        (textout to: ss s " ")

      // copying contents vs. references

      (with s "ABC" s1 "" s2 ""
        (= s1 s)       // string duplication
        (rebind s2 s)  // another reference
        (= s "BCD")
        (textout to: ss s " ")
        (textout to: ss s1 " ")
        (textout to: ss s2 " ")
      )

        (processRes "string_create" (str ss) check)
    )
}
