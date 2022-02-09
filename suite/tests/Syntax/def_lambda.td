/*This file is a part of Transd reference test suit.

  CHECK: lambda definition syntax.*/
#lang transd


Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule : {
    import: "tests",
    check: "5 1 6 7 6 true true",
    ss: StringStream(),
    a: 1,
    b: 2,
    func1: (λ ),
    func2: (λ 5),
    func3: (λ a),
    func4: (λ p Int()),
    func5: (λ p 5 6),
    func6: (λ p 5 (ret p)),
    func7: (λ p Int() -> Int() (ret (+ p 1))),
    //func7: (λ p Int() locals: loc1 "" (ret (+ p 1))),
	_start: (λ 
        (textout to: ss (func1))
        (textout to: ss (func2) " ")
        (textout to: ss (func3) " ")
        (textout to: ss (func4 5))
        (textout to: ss (func5) " ")
        (textout to: ss (func6 7) " ")
        (textout to: ss (func7 5) " ")
        (with res (fst (eval "(λ )"))
            (textout to: ss :boolalpha res " "))
        (with res (fst (eval "(λ p String() (ret p))"))
            (textout to: ss res))
        (processRes "def_lambda" (str ss) check)
    )
}
