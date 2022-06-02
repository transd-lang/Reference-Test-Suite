/*** This file is part of Transd reference test suit.
 File:          recmeth.td
 Created:       Tue, 17 May 2022 12:07
 Last edited:   Чт, 19 май 2022 17:12
 Abstract:      Lambda objects as class members: recursive calling.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

public module Shared: {
    ss: StringStream()
}

class Cl: {
    import: "Shared",
    a: 1,
    rec: Lambda<Int Int>(λ i Int() 
        (+= i 1) (+= a 1)
        (textout to: ss i " " a " ")
        (if (> a 3) (textout to: ss "a>3") (ret))
        (exec rec i)
    )
}

MainModule: {
    import: "tests",
    import: "Shared",
    check: "11 2 12 3 13 4 a>3",
    ob: Cl(),

    _start: (λ 
        (exec ob.rec 10)
        (processRes "recmeth" (str ss) check)
    )
}
