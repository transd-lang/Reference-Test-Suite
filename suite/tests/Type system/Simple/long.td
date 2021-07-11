/*This file is a part of Tourbillon compiler test suit.

  Built-in operations of Long integer type.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "123451 4611686018427387904 -9223372036854775808 18446744073709551615 ",
    l: Long(),
    l1: Long( 0 ),
    ul: ULong( 0 ),
    i1: Int(5),
    
    _start: (λ 
        (= l 123456)
        (textout to: ss (- l i1) " ")
        (with l1 Long( 2 )
            (= l (pow l1 62)))
        (textout to: ss l " ")
        (= l (- l1 l))
        (= l (+ l l))
        (textout to: ss l " ")

        (-= ul 1)
        (textout to: ss ul " ")
        (processRes "long" (str ss) check)
    )
}
