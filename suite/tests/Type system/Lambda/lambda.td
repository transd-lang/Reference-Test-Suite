/*This file is a part of Transd reference test suit.

  Test of lambdas.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }




MainModule: {
import: "tests",
ss: StringStream(),
check: "Hello, Lambda! 64 [\"A\", \"b\", \"C\", \"d\"] 7 10 Hello, World! 5 -15",

lm: Lambda<String Null>(λ s String() (textout to: ss "Hello, " s "! ") ),
lm1: Lambda<Int String>(),
lm2: Lambda<Int Int>(λ i Int() (ret (+ i 20))),

func:(λ lam Lambda<Int Int>() 
        (textout to: ss (exec lam 8) " ")),

_start: (λ 

        // Calling a lambda
        (exec lm "Lambda")

        // Passing an anonymous lambda as parameter
        (func (λ i Int() -> Int() (* i i)))

        // Anonymous lambda as a custom predicate to a built-in function
        (with v ["C","b","A","d" ] 
            (textout to: ss (sort v (lambda l String() r String() -> Bool()
                     (ret (less (toupper l) (toupper r))))) " ") 
        )

        // Inline declaration of an undefined lambda
        (with lam Lambda<Int Null>()
            (rebind lam (λ i Int() -> Null() (textout to: ss (+ i 2) " ")))
            (exec lam 5)
            (rebind lam (λ i Int() -> Null() (textout to: ss (* i 2) " ")))
            (exec lam 5)
        )
        
        // Inline definition
        (with l Lambda<String Null>(λ s String() 
                (textout to: ss "Hello, " s "! ") )

                (exec l "World") //<= Hello, World!
        )

        // Inline rebind

        // Rebind undefined lambda
        (rebind lm1 (λ i Int() -> String() (ret String(i))))
        (textout to: ss (exec lm1 5) " ")

        // Rebind defined lambda
        (rebind lm2 (λ i Int() (ret (- i 20))))
        (textout to: ss (exec lm2 5))

    (processRes "lambda" (str ss) check)
)
}
