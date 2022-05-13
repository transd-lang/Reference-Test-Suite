/*This file is a part of Transd reference test suit.

  A test of pipeline evaluation operator.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "[[\"bcd\", \"dcb\"], [\"def\", \"fed\"]]",
    s : "abc\nbcd\ncde\ndef\nfed\ndcb",
_start: (λ 
    (with v ( -|
        (split s)
        (group-by (λ s String() -> String() 
            (ret (min s (reverse (cp s))))))
        (values)
        (filter where: (λ v Vector<String>() (ret (== (size v) 2))))
        )
        (textout to: ss v)

        (processRes "pipe1" (str ss) check)
))
}
