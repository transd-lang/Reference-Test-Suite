/*This file is a part of Tourbillon compiler test suit.

  A test of pipeline evaluation operator.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "a b c d e f g h",
    succ: false,
    s : "fHaGEbDC",
    _start: (λ 
        (textout to: ss
             ( -| (split s "")
              (sort (lambda l String() r String() -> Bool()
                     (ret (less (tolower l) (tolower r)))))
            //(sort)
             (join " ")
             (tolower)
             (ret)
             ))

        (processRes "pipe" (str ss) check)
    )
}
