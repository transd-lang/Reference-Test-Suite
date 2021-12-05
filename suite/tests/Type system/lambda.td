/*This file is a part of Tourbillon compiler test suit.

  Test of lambdas.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }




MainModule: {
import: "tests",
ss: StringStream(),
check: "Hello, Lambda! 64 7 10 5 Hello, World!",

lm: Lambda<String Null>(λ s String() (textout to: ss "Hello, " s "! ") ),
lm1: Lambda<Int String>(),

func:(λ lam Lambda<Int Int>() 
        (textout to: ss (exec lam 8) " ")),

_start: (λ 
        (exec lm "Lambda")
        (func (λ i Int() -> Int() (* i i)))

        (with lam Lambda<Int Null>()
            (rebind lam (λ i Int() -> Null() (textout to: ss (+ i 2) " ")))
            (exec lam 5)
            (rebind lam (λ i Int() -> Null() (textout to: ss (* i 2) " ")))
            (exec lam 5)
        )
        (rebind lm1 (λ i Int() -> String() (ret String(i))))
        (textout to: ss (exec lm1 5) " ")
        (with l Lambda<String Null>(λ s String() 
                (textout to: ss "Hello, " s "!") )

                (exec l "World") //<= Hello, World!
        )
    (processRes "lambda" (str ss) check)
)
}
