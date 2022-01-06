/*This file is a part of Tourbillon compiler test suit.

  Test of Vector class' methods.

Test's script:

  This test is an implementation of the pancake sorting algorithm.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "[-43, -20, 0, 0, 19, 20, 25, 43, 127]",
    v: Vector<Int>(),
    vint: [43, 25, 127, 0, -43, 19, 0, -20, 20],

    _start: (λ (with n (- (size vint) 1) m 0
            (while n
                (= m (max-element-idx Range(in: vint 0 (+ n 1))))
                (if (neq m n)
                    (if m (reverse Range(in: vint 0 (+ m 1))))
                    (reverse Range(in: vint 0 (+ n 1))))
                (-= n 1)
            )
           (textout to: ss vint)
        )
        (processRes "pancake_sort" (str ss) check)
    )
}
