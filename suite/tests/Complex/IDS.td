/***
 This file is part of the reference test suit of Transd programming language.
 File:          IDS.td
 Created:       Sat, 09 Jul 2022 14:08
 Last edited:   Tue, 06 Sep 2022 04:08
 Author:        Albert Berger.

 Abstract: A schematic implementation of Iterative Deepening Search
 algorithm for finding the best path in a tree of solutions. The program
 (for demonstrating purposes) searches what combination of a given number of
 multipliers gives the product with the largest number of divisors. The depth
 of search corresponds to the number of multipliers. For example, the search
 with depth of 2, and values of multipliers in the interval [1; 10], returns 
 vector [6, 10].

 This test checks and demonstrates two language features: the 'yield'
 statement and recursive lambda calls.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

class Divisors : {
    // cache with numbers of divisors
    m: Index<Int Int>(),

    get: (λ i Int() locals: rt (get-val m i 0)
        (if rt (ret rt))
        (= rt (numdiv i))
        (insert m i rt)
        (ret rt)
    ),
    numdiv: (λ num Int() locals: numd 2 d 0
                (if (eq num 1) (ret 1))
                (for i in Range(2 (to-Int (sqrt num) 1)) do 
                    (if (not (mod num i)) 
                        (= d (/ num i)) (+= numd 1)
                        (if (neq d i) (+= numd 1))))
                (ret numd))
}

public module Shared : {
    divs: Divisors(),
    max_pos: Vector<Int>(),
    max_sc: 0
}

MainModule: {
    import: "tests",
    import: "Shared",
    ss: StringStream(),
    check: "[6, 10] 12",
    interval: 11,
    depth: 2,

    gen_moves: (λ locals: vret Vector<Int>()
        (= vret (for i in Range(1 interval) project (to-Int i)))
        (sort vret (λ l Int() r Int() (ret (< (value r) (value l)))))
        (ret vret)
    ),

    value: (λ mov Int() (ret (get divs mov))),

    move: (λ m Int() pos Vector<Int>() 
        locals: v Vector<Int>(pos) _sc 1
        (append v m)
        (tql v reduce: ["col1"] using: (λ i Int() (*= _sc i)))
        (= _sc (value _sc))
        (if (> _sc max_sc) (= max_pos v) (= max_sc _sc))
        (ret v)
    ),

    moves: Lambda<Int Int Int>(λ pos Vector<Int>() dep Int()
        (if (not dep) (ret pos))
        (for m in (gen_moves) do 
            (yield (exec moves (move m pos) (- dep 1)))
        )
    ),

    _start: (λ 
        (for i in Range(1 interval) do
            (exec moves Vector<Int>() depth)
        )
        (textout to: ss max_pos " " max_sc)
        (processRes "IDS" (str ss) check)
    )
}
