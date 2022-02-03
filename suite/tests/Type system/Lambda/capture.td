/*This file is a part of Transd reference test suit.

  Capturing environment variables in lambdas.

*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


MainModule: {
import: "tests",
ss: StringStream(),
check: "5 5 5 25 25 137",

// Type aliases for shortening type names
Lnn: typealias(Lambda<Null Null>()),
Lii: typealias(Lambda<Int Int>()),

// Environment variable (module field) that
// will be captured in lambda
var1: 5,

// basic capturing: lambda captures 'var1' field
la: Lnn(λ [[var1]] (textout to: ss var1 " ") ),

// non-capturing lambda
la1: Lnn(λ (textout to: ss var1 " ") ),

// this lambda is captured by 'la3' lambda
la2: Lii(λ i Int() (ret (+ i 20))),

// lambda captures 'la2'
la3: Lii(λ [[la2]] (ret (exec la2 5))),

// a lambda with parameters captures 'la2'
la4: Lii(λ [[la2]] i Int() (ret (exec la2 (+ i 100)))),

_start: (λ

  // -- Capturing a data member of the same module --

    (exec la)
    (exec la1)
    (= var1 25) // change the value of var1
    (exec la)   // capturing lambda prints the original value
    (exec la1)  // non-capturing lambda prints the changed var1

  // -- Capturing a lambda

    // 'la2' is rebound to another lambda object
    (rebind la2 Lambda<Int Int>(λ i Int() (ret (- i 30))))

    // 'la3' and 'la4' keep the original 'la2' lambda object
    (textout to: ss (exec la3) " ")
    (textout to: ss (exec la4 17))

    (processRes "capture" (str ss) check)
)
}
