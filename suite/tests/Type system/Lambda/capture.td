/*This file is a part of Tourbillon compiler test suit.

  Capturing environment variables in lambdas.

*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


MainModule: {
import: "tests",
ss: StringStream(),
check: "5 5 5 25 32",

var1: 5,

// lambda captures var1
la: Lambda<Null Null>(λ [[var1]] (textout to: ss var1 " ") ),

// non-capturing lambda
la1: Lambda<Null Null>(λ (textout to: ss var1 " ") ),

// function returns a lambda that captures par1
makeclos: (λ par1 Int()
    (with clos Lambda<Int Int>(λ [[par1]] i Int() (ret (+ i par1)))
        (ret clos)
    )
),

_start: (λ

  // -- Basic capturing --

    (exec la)
    (exec la1)
    (= var1 25) // change the value of var1
    (exec la)   // capturing lambda prints the original value
    (exec la1)  // non-capturing lambda prints the changed var1

  // -- Closures --

    // make a closure with 25 as captured value
    (with clos (makeclos 25)
        (textout to: ss (exec clos 7)) // prints 32
    )

    (processRes "capture" (str ss) check)
)
}
