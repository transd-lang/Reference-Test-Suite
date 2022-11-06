/***
 This file is part of the reference test suit of Transd programming language.
 File:          listComprehension.td
 Created:       Thu, 27 Oct 2022 23:32
 Last edited:   Пт, 28 окт 2022 01:16

 Abstract:  The language's construct for list comprehension closely follows the 
established set-builder notation:

FOR x IN <SET>
WHERE predicate(x)
PROJECT f(x)

The special form of 'for' construct performs list comprehension and returns a collection with selected elements.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
import: "tests",

tst1: (λ
//In basic form, the returned vector is created and filled automatically:

(with v (for x in Seq(10) project (* x x))
    (if (not (eq v [0, 1, 4, 9, 16, 25, 36, 49, 64, 81])) (throw "tst1")))
),

tst2: (λ
// Basic form with where clause:

(with v (for x in Seq(10) where (mod x 2) project Vector<Int>([x,(* x x)]))
    (if (not (eq v [[1, 1], [3, 9], [5, 25], [7, 49], [9, 81]])) (throw "tst2")))
),


tst3: (λ locals: n 16
(with v (for x in Seq(1 n) project<Vector<Int>>
        (for y in Seq(x n) do 
            (for z in Seq(y n) 
            where (== (* z z) (+ (* y y) (* x x)))
            do (append @projRes Vector<Int>([x,y,z])))))
        (if (not (eq v [[3, 4, 5], [5, 12, 13], [6, 8, 10], [9, 12, 15]])) (throw "tst3")))
),

_start: (λ locals: check "OK"
    (try (tst1) (tst2) (tst3) (catch (= check (str @ex))))
    (processRes "list-comprehension" check "OK")
)
}
