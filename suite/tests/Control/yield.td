/*** This file is a part of Transd reference test suit.
 File:          yield.td
 Created:       Wed, 18 May 2022 10:49
 Last edited:   Wed, 29 Jun 2022 23:06
 Abstract:      Test of 'yield' statement.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "1 1 1",

	func: Lambda<Null Int>(λ 
        locals: a 0
        (yield a) (+= a 1)
        (yield a) (+= a 1)
        (yield a)
    ),

	func1: Lambda<Null Int>(λ
        locals: a 0
        (yield a) (+= a 1)
        (yield a) (+= a 1)
        (ret a)
    ),

	func2: Lambda<Null Int>(λ
        (for i in Range(2) do
            (yield (to-Int i)))
        (throw :stopIter)
    ),

    tst1: (λ locals: ss StringStream()
        (for i in Range(7) do
            (textout to: ss (exec func) " "))
        (if (eq (str ss) "0 1 2 2 3 4 4 ") (ret "1") else (ret (str ss)))
    ),

    tst2: (λ locals: ss StringStream()
        (for i in Range(7) do
            (textout to: ss (exec func1) " "))
        (if (eq (str ss) "0 1 2 0 1 2 0 ") (ret "1") else (ret (str ss)))
    ),

    tst3: (λ locals: ss StringStream() k 0
        (while true
            (try (= k (exec func2))
                (textout to: ss k " ")
                (catch break))
        )
        (textout to: ss "Done")
        (if (eq (str ss) "0 1 Done") (ret "1") else (ret (str ss)))
    ),

    _start: (λ 
        (textout to: ss (tst1) " ")
        (textout to: ss (tst2) " ")
        (textout to: ss (tst3))

        (processRes "yield" (str ss) check)
    )
}
