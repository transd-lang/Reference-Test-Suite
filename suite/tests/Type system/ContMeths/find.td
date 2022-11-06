/***
 This file is part of the reference test suit of Transd programming language.
 File:          find.td
 Created:       Sat, 05 Nov 2022 10:14
 Last edited:   Sun, 06 Nov 2022 15:46
 Abstract: Generic container method 'find'.

'(find)' takes one argument: the value to found. It returns the Position
object referring to the first found value in the container, or to the container's
past-last-element position if the value is not found.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",

    // Boxed and unboxed containers.
    v: [20,21,22,23,24,25,26,27,28,29],
    m: Index<String Int>({"one":11, "two":22, "three":33}),
    s: "abcdefghijklm",
    b: ByteArray([0,1,2,3,4,5,6,7,8,9]),

    // The Position object returned by '(find)' has '(get-idx)' method, which
    // returns the index of the found element in the container.
    tst1: (λ 
        (or (and (eq (get-idx (find b 5)) 5) 
                      (eq (get-idx (find v 28)) 8)
                      (eq (get-idx (find s Char("h"))) 7)
                      (eq (get-idx (find m "two")) "two"))
                (throw "tst1"))
    ),
    
    // The '(get-val)' method of the Position class returns a *copy* of the
    // value for unboxed containers, and a *reference* to the found
    // element for boxed containers. Which reference can be used for modifying
    // element's boxed value.
    tst2: (λ 
        (with v [100, 101, 102] m Index<String Int>({"one":11, "two":22, "three":33})
            (= (get-val (find v 101)) 500)
            (= (get-val (find m "one")) 99)
            (or (and (eq (get v 1) 500) (eq (get m "one") 99)) (throw "tst2"))
        )
    ),
    
    // If the value is not found, '(find)' returns the past-last-element
    // position.
    tst3: (λ locals: ss StringStream() check "01010101"
        (textout to: ss 
            (is-end (find v 25)) (is-end (find v 19)) 
            (is-end (find m "three")) (is-end (find m "four"))
            (is-end (find s Char("m"))) (is-end (find s Char("n")))
            (is-end (find b 0)) (is-end (find b 10)))
        (if (neq check (str ss)) (throw String("tst3: " (str ss))))
    ),

    // '(find)' can be called not only on whole containers, but also on ranges.
    tst4: (λ locals: ss StringStream()
        (textout to: ss 
            (get-val (find Range(in: v 5 -1) 28)) " "
            (get-val (find Range(in: s 0 6) Char("d"))) " " 
            (get-val (find Range(in: b 0 6) 5)))
        (if (neq (str ss) "28 d 5") (throw String("tst4:" (str ss))))
    ),

	_start: (λ locals: check "OK"
        (try (tst1) (tst2) (tst3) (tst4)
        (catch (= check (str @ex))))

        (processRes "find" check "OK")
    )
}
