/*** This file is a part of Transd reference test suit.
 File:          yield1.td
 Created:       Thu, 07 Jul 2022 19:25
 Last edited:   Tue, 13 Sep 2022 18:03

 Abstract: Yield statement in functions with parameters.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "1 1 1 1",

    func: Lambda<Int Int>(λ p Int()
        locals: a 0
        (yield a) (+= a p)
        (yield a) (+= a p)
        (yield a)
    ),

    func1: Lambda<Int Int>(λ p Int()
        locals: a 0
        (yield a) (+= a p)
        (yield a) (+= a p)
        (yield a)
    ),

    func2: Lambda<Int Int>(λ p Int()
        locals: a 0
        (yield a) (+= a p)
        (yield a) (+= a p)
        (ret a)
    ),

    func3: Lambda<Int Int>(λ p Int()
        (for i in Range(5) do
            (yield (+ p i)))
        (throw :stopIter)
    ),

    tst1: (λ locals: ss StringStream()
        (for i in Range(10) do
            (textout to: ss (exec func (to-Int i)) " "))
        (if (eq (str ss) "0 0 0 0 0 0 0 0 0 0 ") (ret "1") else (ret (str ss)))
    ),

    tst2: (λ locals: ss StringStream()
        (for i in Range(1 10) do
            (textout to: ss (exec func1 (to-Int i)) " "))
        (if (eq (str ss) "0 1 2 2 3 4 4 5 6 ") (ret "1") else (ret (str ss)))
    ),

    tst3: (λ locals: ss StringStream()
        (for i in Range(10) do
            (textout to: ss (exec func2 (to-Int i)) " "))
        (if (eq (str ss) "0 0 0 0 3 6 0 6 12 0 ") (ret "1") else (ret (str ss)))
    ),

    tst4: (λ locals: ss StringStream() k 0
        (while true
            (try (= k (exec func3 3))
                (textout to: ss k " ")
                (catch break))
        )
        (textout to: ss "Done")
        (if (eq (str ss) "3 4 5 6 7 Done") (ret "1") else (ret (str ss)))
    ),

    _start: (λ 
        (textout to: ss (tst1) " ")
        (textout to: ss (tst2) " ")
        (textout to: ss (tst3) " ")
        (textout to: ss (tst4))

        (processRes "yield1" (str ss) check)
    )
}
