/*This file is a part of Transd reference test suit.

  A test of pipeline evaluation operator.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "a b c d e f g h",
    s : "fHaGEbDC",
    _start: (λ 
        (textout to: ss
             ( -| (split s "")
              (sort (lambda l String() r String() -> Bool()
                     (ret (less (toupper l) (toupper r)))))
            //(sort)
             (join " ")
             (tolower)
             (ret)
             ))

        (processRes "pipe" (str ss) check)
    )
}
