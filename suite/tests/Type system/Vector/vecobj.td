/*This file is a part of Transd reference test suit.

  Test of using a vector as a dataset in data queries.

*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

class Point : {
    x: Double(),
    y: Double(),
    @init: (λ v Vector<Double>() (= x (get v 0)) (= y (get v 1))),
    print: (λ ss StringStream() (textout to: ss "(" x "; " y ")" ))
}

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "(1; 2)(3; 4)",
    v: Vector<Point>([[1.0, 2.0], [3.0, 4.0]]),
    
    _start: (λ 
        (for p in v do (print p ss))

        (processRes "vector_vecobj" (str ss) check)
    )
}
