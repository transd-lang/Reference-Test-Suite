/***
 File:          pars.td
 Created:       Sun, 03 Jul 2022 02:42
 Last edited:   Sun, 03 Jul 2022 21:03
 Abstract: Initialization of function parameters.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule : {
import: "tests",
ss: StringStream(),

// 'p' - is a required parameter
tst1: (λ p Int()
    (ret p)
),

// 'p' will be assigned a default value 2 in case an argument is not passed
tst2: (λ p Int(2)
    (ret p)
),

_start: (λ 
    (with check "0 5 2"

        // call without a needed parameter causes exception
        (textout to: ss (fst (eval "(tst1)")) " ")
        
        // call with a parameter
        (textout to: ss (tst2 5) " ")

        // default parameter value allows omitting the parameter
        (textout to: ss (tst2))

        (processRes "pars" (str ss) check)
    )
)
}
