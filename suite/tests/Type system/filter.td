/*This file is a part of Tourbillon compiler test suit.

  Filter built-in type operations.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    a: 0,
    b: 10,
    ss: StringStream(),
    check: String("4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 " 
"[0, 1, 2, 3, 4]"),
    succ: false,
    
    _start: (λ 
        (for i in Filter( Seq( (+ a 2) (- 30 b ) )
                          apply: (lambda (* @it 2))) do
            (textout to: ss i " "))
        (with f Filter( Seq( 0 5 ) apply: (lambda
                (ret @it)))
            (textout to: ss (to-vector f))
        )
        (processRes "filter" (str ss) check)
    )
}
