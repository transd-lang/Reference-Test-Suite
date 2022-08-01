/*This file is a part of Transd reference test suit.

  A test of the name resolving in cross-module function calls.

  NR routes:

  nam1:mem_a | FTfunc1:B | FTFunc:A | contA
  nam1:mem_a | BIMeth | FTFunc1:B | FTFunc:A | contA

  Spec:
    NR/spec_3
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }


public module mod1 : {
    import: "mod2",
    import: "ClA",
    field1: 35,
    field3: 6,
    func1: (λ par Int() 
        (with ob ClA() (func2 ob field3))
    ),
    func2: (λ par Int() (textout "mod1::func2(): " (+ par field1)))
}

public module mod2 : {
    field1: 50,
    func2: (λ par Int() String("mod2::func2(): " (+ par field1)))
}

class ClA : {
    field1: 4,
    field3: 65,
    func2: (λ par Int() (ret String("ClA::func2():" (+ par field1))))
}

MainModule : {
    import: "tests",
    import: "mod1",
    //check: "5 1 5 5 ClA::func2():10",
    check: "5 5 5 ClA::func2():10",
    ss: StringStream(),
    field1: 1,

    
    func1: (λ 5),
    //func2: (λ field1),
    func3: (λ par Int() (ret par)),
    func4: (λ par Int() (func3 par)),

    test1: (λ (textout to: ss (func1) " ")),
    //test2: (λ (textout to: ss (func2) " ")),
    test3: (λ (textout to: ss (func3 5) " ")),
    test4: (λ (textout to: ss (func4 5) " ")),
    _start: (λ 
        (test1)
        //(test2)
        (test3)
        (test4)
        (textout to: ss (mod1::func1 10))

        (processRes "NR" (str ss) check)
    )

}
