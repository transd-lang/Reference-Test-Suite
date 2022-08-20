/***
 This file is part of the reference test suit of Transd programming language.
 File:          dynsubject1.td
 Created:       Tue, 02 Aug 2022 14:16
 Last edited:   Tue, 02 Aug 2022 14:27

 Abstract: Continuation of dynamic subject tests from dynsubject.td
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

TypeAlias: {
Move: typealias(Tuple<Int Int>)
}

class ClA: {
    mem1: Int(),

    @init: (λ i Int() (set mem1 (/ i 2))),

    value: (λ mov Move()
        locals: j (snd mov) _sc (- 40 mem1)
        (if (< (abs (- j mem1)) 20) (+= _sc 17))
        (ret _sc)
    ),

    meth1: (λ mov Move()
        locals: _mem1 (+ mem1 (value mov))
        (ret (+ _mem1 mem1))
    ),

    meth2: (λ mov Move()
        locals: i (fst mov) j (snd mov)
        (ret (+ i j mem1))
    )
}


MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "82 43",

    _start: (λ 
        locals: hist Vector<ClA>()
        (append hist ClA(50))
        (textout to: ss (meth1 (get hist -1) [[7, 11]]) " ")
        (textout to: ss (meth2 (get hist -1) [[7, 11]]))

        (processRes "dynsubject1" (str ss) check)
    )
}
