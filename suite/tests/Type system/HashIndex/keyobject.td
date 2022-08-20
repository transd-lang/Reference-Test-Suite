/***
 This file is part of the reference test suit of Transd programming language.
 File:          keyobject.td
 Created:       Tue, 31 May 2022 23:48
 Last edited:   Fri, 19 Aug 2022 21:38

 Abstract: Using compound objects as keys in HashIndex.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

class PT2 : {
	x : Double(),
	y : Double(),
	@init: (λ x_ Double() y_ Double() (set x x_) (set y y_)),
	@to-String: (λ ss StringStream() (textout to: ss "(" :fixed prec: 1 x "; " y ")" ) )
}


MainModule : {
    import: "tests",
    Key: typealias(Tuple<PT2 Int>),
    i1:  HashIndex<PT2 String>(),
    i2: HashIndex<Key String>(),

    // test 1 - using an object of a user defined class as key
    tst1: (λ locals: ss StringStream()
        check "false {(2.0; 3.0) : \"two-three2\", (1.0; 2.0) : \"one-two\"}"
        (insert i1 PT2(1.0 2.0) "one-two")
        (insert i1 PT2(2.0 3.0) "two-three")
        // try to insert an existing key
        (textout to: ss :boolalpha 
            (fst (eval "(insert i1 PT2(2.0 3.0) \"two-three1\")")) " ")
        (set-el i1 PT2(2.0 3.0) "two-three2")
        (textout to: ss i1)
        
        (if (eq (str ss) check) (ret "1"))
            (lout (str ss)) (ret "0")
    ),

    // test 2 - tuple with a user object as key
    tst2: (λ locals: ss StringStream()
        check "{[[(1.0; 2.0), 1]] : \"one-two\"}"
        (insert i2 [[PT2(1.0 2.0), 1]] "one-two")
        (textout to: ss i2)

        (if (eq (str ss) check) (ret "1"))
            (lout (str ss)) (ret "0")
    ),

    // test 3 - fetching a value
    tst3: (λ locals: ss StringStream() check "one-two"
        a 1.0 b 2.0 c 1
        (textout to: ss (get i2 [[PT2(a b), c]]))

        (if (eq (str ss) check) (ret "1"))
            (lout (str ss)) (ret "0")
    ),
	
	_start: (λ (with check "1 1 1" ss StringStream()
        (textout to: ss (tst1) " ")
        (textout to: ss (tst2) " ")
        (textout to: ss (tst3))

        (processRes "keyobject" (str ss) check)
    ))
}
