/***
 This file is part of the reference test suit of Transd programming language.
 File:          init1.td
 Created:       Wed, 03 Aug 2022 11:57
 Last edited:   Sat, 06 Aug 2022 16:44

 Abstract: Continuation of tests of initializing vectors with data.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

class PT2 : {
	x : Double(),
	y : Double(),
	@init: (λ x_ Double() y_ Double() (set x x_) (set y y_)),
	@to-String: (λ ss StringStream() (textout to: ss "(" :fixed prec: 1 x "; " y ")" ) )
}

MainModule: {
import: "tests",
ss: StringStream(),
Tpi: typealias(Tuple<PT2 Int>),
v: Vector<Int>(),
a: 5,
b: 6,

// test 1: using a parameter as value initializer
// for a scoped vector object
func: (λ i Int() locals: ss StringStream()
    (with v Vector<Int>([i])
        (= i 10)
        (append v i)
        (textout to: ss v))
    (if (eq (str ss) "[5, 10]") (ret "1"))
    (lout (str ss)) (ret "0")
),

// test 2: using module fields as value initializers
// for a scoped vector object
func1: (λ locals: ss StringStream() check
"[5, 2, 6] [5, 2, 6]
[10, 6] [10, 6]"
    (with v [a,2,b]
        (textout to: ss v " ")
        (= a 10)
        (lout to: ss v)
    )
    (append v a)
    (append v b)
    (textout to: ss v " ")
    (= a 15)
    (textout to: ss v)
    (= a 5)
    (if (eq (str ss) check) (ret "1"))
    (lout (str ss)) (ret "0")
),

// test 3: inline constructors as value initializers
// of vectors and vectors' elements
func2: (λ i Double()
    locals: v Vector<Tpi>() v1 Vector<Vector<PT2>>()
    ss StringStream() check
"[[[(5.0; 7.0), 1]]] [[(5.0; 7.0)]]"
    (append v [[PT2((to-Double a) i), 1]])
    (append v1 [PT2((to-Double a) i)])
    (textout to: ss v " ")
    (textout to: ss v1)
    (if (eq (str ss) check) (ret "1"))
    (lout (str ss)) (ret "0")
),

// test 4: initializing vector with value initializers
// in a loop
func3: (λ v Vector<Int>() 
    locals: res Vector<Tuple<Int Int>>()
    ss StringStream()
    check "[[[5, 6]], [[7, 8]]]"
    (for i in v do
         (append res [[i, (+ i 1)]])
    )
    (textout to: ss res)
    (if (eq (str ss) check) (ret "1"))
    (lout (str ss)) (ret "0")
),

_start: (λ (with check "1 1 1 1"
    (textout to: ss (func 5) " ")
    (textout to: ss (func1) " ")
    (textout to: ss (func2 7.0) " ")
    (textout to: ss (func3 [5, 7]))
    (processRes "init1" (str ss) check))
)
}
