/*This file is a part of Transd reference test suit.
 Last edited:   Sun, 19 Jun 2022 02:59

  Testing the Vector methods.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: 
"10 1 0 [1, 2, 3] [4, 5, 6] [][4, 5, 6]
5 6 false false
true false 3
[6, 3, 4, 9, 2, 7, 0, 1, 8, 5] [4, 9, 2, 7, 0, 1] false true 
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9] [0, 1, 2, 4, 7, 9] false true 
1 4 false false
1",

    const v: [5,8,1,0,7,2,9,4,3,6],
    v1: [12,13,14,15,16,17],

    tst-eq: (λ const v Vector<Int>() const v1 Vector<Int>()
                (textout to: ss (eq v v1) " ")
           ),

    tst-set: (λ l Vector<Int>() const r Vector<Int>()
        (textout to: ss l " ")
        (= l r)
        (textout to: ss l " ")
        (clear l)
        (textout to: ss l r)
    ),

    tst-back: (λ const par Vector<Int>() 
                (textout to: ss (front par) " " (back par)  " ")
                (with v Vector<Int>()
                    (textout to: ss :boolalpha 
                        (fst (eval "(front v)")) " " (fst (eval "(back v)"))
    ))),

    tst-find-adjacent: (λ const par Vector<Int>()
        (with pos (find-adjacent v)
            (textout to: ss (eq pos (end v)) " "
               (fst (eval "(get-el pos)")) " ")
            (= pos (find-adjacent par))
            (textout to: ss (get-val pos))
    )),
    
    tst-reverse: (λ const cont Vector<Int>()
        (textout to: ss (reverse (cp cont)) " ")
    ),

    tst-sort: (λ const cont Vector<Int>()
        (textout to: ss (sort (cp cont)) " ")
    ),

    tst-mul: (λ locals: ss StringStream() v [1,2,3]
        (textout to: ss (mul v 3))
        (if (eq (str ss) "[1, 2, 3, 1, 2, 3, 1, 2, 3]") 
            (ret "1") else (ret (str ss)))
    ),

    _start: (λ 
        //-- (size)
        (textout to: ss (size v) " ")

        //-- (eq)
        (tst-eq v (cp v)) 
        (tst-eq v [0,1,2])

        //-- (set)
        (tst-set [1,2,3] [4,5,6])
        (lout to: ss "")

        //-- (back)
        (tst-back v)
        (lout to: ss "")

        //--(begin), (find-adjacent)
        (tst-find-adjacent [0,1,2,3,3,4,5,6,6,7])
        (lout to: ss "")

        //-- (reverse)
        (tst-reverse v)
        (tst-reverse Vector<Int>(Range(in: v 2 -2)))
        (textout to: ss (fst (eval "(reverse Range(in: v 2 -2))")) " ")
        (textout to: ss (fst (eval "(reverse Range(in: v1 2 -2))")) " ")
        (lout to: ss "")

        //-- (sort)
        (tst-sort v)
        (tst-sort Vector<Int>(Range(in: v 2 -2)))
        (textout to: ss (fst (eval "(sort Range(in: v 4 -4))")) " ")
        (textout to: ss (fst (eval "(sort Range(in: v1 2 -2))")) " ")
        (lout to: ss "")
        
        //-- (front) (back)
        (with v [1,2,3,4]
	        (textout to: ss (front v) " " (back v) (clear v) " "
                (fst (eval "(front v)")) " " (fst (eval "(back v)")))
        )
        (lout to: ss "")

        //-- (mul)
        (textout to: ss (tst-mul))

        (processRes "vector:meths" (str ss) check)
    )
}
