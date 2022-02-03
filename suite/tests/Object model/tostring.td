/*This file is a part of Transd reference test suit.

  A test of @to-String special object's method.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }


private module MainModule: {
    import: "Quad",
    import: "tests",
    check: "Quad:{ mem1: 2 }",

    _start: (λ (with q Quad( 5 ) ss StringStream()
                (@to-String q ss)
                (processRes "tostring" (str ss) check))
            )
}


class Quad: {
    mem1: Int(),

    @init: (λ i Int() (set mem1 (/ i 2))),
    
    @to-String: (λ ss StringStream() 
                    (textout to: ss 
                "Quad:{ mem1: " mem1 " }"))

}
