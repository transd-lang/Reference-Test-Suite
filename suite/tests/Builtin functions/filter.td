/*This file is a part of Transd reference test suit.

  Test of (filter) function.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }



private module MainModule: {
    import: "tests",
    check: 
"[101, 103, 105, 107, 109]
[1, 3, 5, 7, 9]
[101, 102, 103, 104, 105, 106, 107, 108, 109]
",
    ss: StringStream(),
    v: [1,2,3,4,5,6,7,8,9],

    _start: (λ
        (lout to: ss
            (filter v 
              where: (λ i Int() (ret (mod i 2)))
              (λ i Int() (ret (+ i 100)))))
        (lout to: ss
            (filter v 
              where: (λ i Int() (ret (mod i 2)))
              ))
        (lout to: ss
            (filter v 
              (λ i Int() (ret (+ i 100)))))

        (processRes "filter" (str ss) check)
    )
}

