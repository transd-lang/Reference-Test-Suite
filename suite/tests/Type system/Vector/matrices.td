/*This file is a part of Transd reference test suit.

  Vector operations.
  Testing various methods of vector construction and
  'ret' form.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    n: 3,
    rowA: Vector<Double>(),
    rowC: Vector<Double>(),
    colC: Double(),
    ss: StringStream(),
    check: "[[9, 6, 3], [9, 6, 3], [9, 6, 3]]",
    
    _start: (λ
        (with 
            A (for i in Range(n) project
                (for k in Range(n) project (to-Double k)))
            B (for i in Range(n) project
                (for k in Range(n) project (to-Double (- n k))))
            C (for i in Range(n) project
                (for k in Range(n) project 0.0))

        (for i in Range( n ) do 
            (rebind rowA (get A i)) 
            (rebind rowC (get C i))
            (for j in Range( n ) do 
                (rebind colC (get rowC j))
                (for k in Range( n ) do 
            (+= colC (* (get rowA k) (get (get B k) j)))
        )))
        (textout to: ss C)
        )

        (processRes "matrices" (str ss) check)
    )
}
