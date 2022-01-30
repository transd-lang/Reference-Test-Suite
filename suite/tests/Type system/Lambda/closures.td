/*This file is a part of Tourbillon compiler test suit.

  Closures.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


MainModule: {
import: "tests",
ss: StringStream(),
check: "32 107 105",

Lii: typealias(Lambda<Int Int>()),


// lambda which is passed as a parameter to a closure and captured
la: Lii(λ i Int() (ret (+ i 100))),

// function returns a lambda that captures par1:Int()
makeclos: (λ par1 Int()
    (with clos Lii(λ [[par1]] i Int() (ret (+ i par1)))
        (ret clos)
    )
),

// function returns a lambda that captures another lambda
makeclos1: (λ fn Lii()
    (with clos Lambda<Int Int>(λ [[fn]] i Int() 
            (textout to: ss (exec fn i) " "))
        (ret clos)
    )
),

// This closure maker is itself a lambda, which receives another
// lambda as argument, and returns yet another lambda, which captures
// the second one. This is a prototype to Y-combinator.

makeclos2: Lambda<Lambda<Int Int> Lambda<Int Int>>(λ fn Lii()
                    (ret (λ [[fn]] v Int() (exec fn v)))),

_start: (λ
    // make a closure with 25 as captured value
    (with clos (makeclos 25)
        (textout to: ss (exec clos 7) " ") // prints 32
    )

    // make a closure with another lambda as captured value
    (with clos (makeclos1 la)
        (exec clos 7) // prints 107
    )

    // similar to the previous one, but the closure maker is itself
    // a lambda, which makes it suitable for using in constructions
    // like Y-combinator.

    (with clos (exec makeclos2 la)
        (textout to: ss (exec clos 5)))

    (processRes "closures" (str ss) check)
)
}
