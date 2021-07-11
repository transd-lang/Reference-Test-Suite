/*This file is a part of Tourbillon compiler test suit.

  Filter built-in type operations.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "284, 220",
    succ: false,
    
    _start: (λ 
        (with sum 0 d 0 f Filter( Seq( 1 300 ) apply: (lambda
                (= sum 1)
                (for i in Range(2 (to-Int (sqrt @it))) do 
                    (if (not (mod @it i)) 
                        (= d (/ @it i)) (+= sum i)
                        (if (neq d i) (+= sum d))))
                (ret sum)))
            (with v (to-vector f)
                (for i in v do
                    (if (and (< i (size v)) 
                             (eq (+ @idx 1) (get v (- i 1))) 
                             (< i (get v (- i 1))))
                        (textout to: ss (+ @idx 1) ", " i )
                    )
                )
            )
        )
        (processRes "filter1" (str ss) check)
    )
}
