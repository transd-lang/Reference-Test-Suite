/*** This file is a part of Transd reference test suit.
 File:          init.td
 Created:       Tue, 05 Jul 2022 09:21
 Last edited:   Tue, 05 Jul 2022 15:38
 Abstract: Test of @init special method.

When a class defines the special method '@init', this method is automatically
called when an object of the class is created. The method can receive arguments
that are passed to the class constructor at the object creation.
The method can define default values for parameters when those are not provided.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

class ClA: {
    x: Int(), y: Int(),

    // p1 - required parameter, p2 - has a default value
    @init: (λ p1 Int() p2 Int(27) (= x p1) (= y p2)),

    @to-String: (λ ss StringStream() 
        (textout to: ss "x: " x "; y: " y))
}

MainModule : {
    import: "tests",
    ss: StringStream(),
    check: "1 1 1",
    
    // create an object providing both parameters
    tst1: (λ locals: ss StringStream()
        (textout to: ss ClA(7 8))
        (if (eq (str ss) "x: 7; y: 8") (ret "1"))
        (lout (str ss)) (ret "0")
    ),
	
    // create an object providing only one parameter
    tst2: (λ locals: ss StringStream()
        (textout to: ss ClA(10))
        (if (eq (str ss) "x: 10; y: 27") (ret "1"))
        (lout (str ss)) (ret "0")
    ),
	
    // missing required parameter causes an exception
    tst3: (λ locals: ss StringStream()
        (textout to: ss (fst (eval "(textout ClA())")))
        (if (eq (str ss) "0") (ret "1"))
        (lout (str ss)) (ret "0")
    ),
	
    _start: (λ 
        (textout to: ss (tst1) " ")
        (textout to: ss (tst2) " ")
        (textout to: ss (tst3))

        (processRes "init" (str ss) check)
    )
}
