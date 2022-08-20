/***
 File:          ret.td
 Created:       Mon, 08 Aug 2022 13:08
 Last edited:   Mon, 08 Aug 2022 14:34

 Abstract: Returning tuples.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

class PT2 : {
	x : Double(),
	y : Double(),
	@init: (λ x_ Double() y_ Double() (set x x_) (set y y_)),
	@to-String: (λ ss StringStream() (textout to: ss "(" :fixed prec: 1 x "; " y ")" ) )
}

class ClA: {
    meth: (λ p Int() locals: loc Int() pt PT2((to-Double p) 6.0)
        (for i in Range(1 3) do (= loc i)
            (yield Tuple<Int ULong PT2>([[loc, i, pt]]))
        )
        (ret Tuple<Int ULong PT2>([[99, ULong(88), PT2(8.0 9.0)]]))
    )
}

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "abcd",

    tst1: (λ locals: ob ClA() ss StringStream() check
"[[1, 1, (0.0; 6.0)]]
[[2, 2, (1.0; 6.0)]]
[[99, 88, (8.0; 9.0)]]
[[1, 1, (3.0; 6.0)]]
"

    (for i in Range(4) do
        (lout to: ss (meth ob (to-Int i))))

    (if (eq (str ss) check) (ret "1"))
        (lout (str ss)) (ret "0")
    ),

    _start: (λ (with check "1" ss StringStream()
        (textout to: ss (tst1))

        (processRes "ret" (str ss) check)
    ))
}
