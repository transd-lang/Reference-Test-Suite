/*This file is a part of Transd reference test suit.

  Test of '(reverse)' SeqContainer method.

*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "[5, 4, 3, 2, 1, 0, -1, -2, -3] [4, 3, 2, 1, 0, -1, -2] 
false false false [4, 3, 2, 1, 0, -1, -2] true",
    emptvint: Vector<Int>(),
    vint: [-3,-2,-1,0,1,2,3,4,5],
    const cvint: [-3,-2,-1,0,1,2,3,4,5],

    tst-cvint: (λ const cont Vector<Int>()
        (textout to: ss (reverse (cp cont)) " ")
    ),
    
    tst-vvint: (λ cont Vector<Int>()
        (textout to: ss (reverse cont) " ")
    ),

    tst-fail-cvint: (λ const _cont Vector<Int>()
        //locals: la Lambda<Null Null>(λ [[cont]] (reverse cont))
        // cObj -> vMeth
        // cArg -> vMeth
        // cObj -> vArg
        // cArg -> vArg
        (textout to: ss :boolalpha (fst (eval "(reverse _cont)")) " ")
        (textout to: ss (fst (eval "(reverse Range(in: _cont 1 -1))")) " ")
        (textout to: ss (fst (eval "(tst-vvint _cont)")) " ")
        (textout to: ss (fst (eval "(tst-vvint Vector<Int>(Range(in: _cont 1 -1)))")))
//(tst-vvint Vector<Int>(Range(in: cont 1 -1)))
    ),
    
    
    _start: (λ 
        (tst-cvint cvint)
        (tst-cvint Vector<Int>(Range(in: cvint 1 -1)))
        (lout to: ss "")
        (tst-fail-cvint cvint)


        (processRes "reverse" (str ss) check)
    )
}
