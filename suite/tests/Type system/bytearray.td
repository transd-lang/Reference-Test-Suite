/*This file is a part of Tourbillon compiler test suit.

  ByteArray built-in type operations.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: 
"5 [0, 1, 2] [5, 4, 3, 2, 1] [4, 3, 2] false true 
[0, 1, 2, 3, 4, 5, 6, 7, 8] [0, 1, 3, 4, 7] false true 
0 3 false false",
    const arr: ByteArray([1,2,3,4,5]),
    arr1: ByteArray([21,22,23,24,25]),

    ctor: (λ 
        (textout to: ss ByteArray([0,1,2]) " ")
    ),

    tst-reverse: (λ const cont ByteArray()
        (textout to: ss (reverse (cp cont)) " ")
    ),

    tst-sort: (λ const cont ByteArray()
        (textout to: ss (sort (cp cont)) " ")
    ),

    _start: (λ 
        //-- (size)
        (textout to: ss (size arr) " ")

        //-- (ctor)
        (ctor)

        //-- (reverse)
        (tst-reverse arr)
        (tst-reverse ByteArray(Range(in: arr 1 -1)))
        (textout to: ss (fst (eval "(reverse Range(in: arr 2 -2))")) " ")
        (textout to: ss (fst (eval "(reverse Range(in: arr1 2 -2))")) " ")
        (lout to: ss "")

        //-- sort
        (with const ar ByteArray([6,8,1,0,7,3,4,2,5])
            (tst-sort ar)
            (tst-sort ByteArray(Range(in: ar 2 -2)))
            (textout to: ss (fst (eval "(sort Range(in: ar 2 -2))")) " ")
            (textout to: ss (fst (eval "(sort Range(in: arr1 2 -2))")) " ")
        )
        (lout to: ss "")

        (with ar ByteArray([0,1,2,3])
	        (textout to: ss (front ar) " "(back ar) (clear ar) " "
                (fst (eval "(front ar)")) " " (fst (eval "(back ar)")) )
        )

        (processRes "bytearray" (str ss) check)
    )
}
