/*This file is a part of Transd reference test suit.

  Range built-in type operations.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    succ: false,
    r: Range(0 5),
    check: String( "10 11 12 13 14 "
"5 6 7 8 9 "
),
    
    v: [10,11,12,13,14,15,16,17,18,19],
    a: 8,
    _start: (λ 
        (for i in r do 
            (textout to: ss (get v i) " ")
        )
        (= a 5)
        (for el in Range(a (size v)) do 
            (textout to: ss el " ")
        )
        (processRes "range" (str ss) check)
    )
}
