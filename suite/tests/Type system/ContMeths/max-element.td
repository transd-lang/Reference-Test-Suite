/*This file is a part of Transd reference test suit.

  Test of:
    'max' :Integer method;
    'max-element' container method;
    'max-element-idx' container method.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "11 0 false false false 274 3 exception true -1",

	_start: (λ 
        //-- (max) --

        (textout to: ss (max 9 6 2 11 3 4) " ")
        (textout to: ss (max 0 0) " ")
        (textout to: ss :boolalpha 
                        (fst (eval "(max )")) " " 
                        (fst (eval "(max 0)")) " "
                        (fst (eval "(max 0 0.001)")) " ")

        //-- (max-element), (max-element-idx)
        (with v [1, 45, 7, 274, -2, 34] v1 Vector<Int>()
            // non-empty container
            (textout to: ss (get-el (max-element v)) " ")
            (textout to: ss (max-element-idx v) " ")

            // empty container
            (with pos (max-element v1)
                (try
                    (textout to: ss (get-el pos) " ")
                (catch (textout to: ss "exception ")))
                (textout to: ss (eq pos (end v1)) " ")
            )
            (textout to: ss (max-element-idx v1))
        )

        (processRes "max-element" (str ss) check)
    )
}
