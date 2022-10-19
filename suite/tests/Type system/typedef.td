/***
 File:          typedef.td
 Created:       Fri, 30 Sep 2022 01:37
 Last edited:   Fri, 30 Sep 2022 02:12
 Abstract: Abstract types and 'typedef' feature.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }


MainModule: {
import: "tests",
ss: StringStream(),
check: "11",

// To define a new type we pair up the name of new type with a lambda
// predicate for checking objects on belonging to the new type
Vec: typedef(Lambda<:Data Bool>(λ d :Data() 
        (starts-with (_META_type d) "Vector<"))),

// The function is polymorphic and accepts objects of the newly created 'Vec' 
// abstract type, which represents vectors of any type.
// The function performs Sattolo cycle shuffling on a vector. 
// Sattolo cycle permutates elements, not leaving any element on its original
// place.
sshuffle: (λ v Vec() locals: rnd 0 
        (for n in Range( (- (size v) 1) 0) do
            (= rnd (randr (to-Int (- n 1))))
            (with tmp (cp (get v n))
                (set-el v n (get v rnd))
                (set-el v rnd tmp))
        )
    ),
_start: (λ
    (with v [10,20,30,40,50,60,70,80,90,100] b Bool(true)
        (sshuffle v)
        (for el in v do (if (== el (* (+ @idx 1) 10)) (= b false) break))
        (textout to: ss b)
    )
    (with v ["A","B","C","D","E","F","G","H"] b Bool(true) v1 Vector<String>()
        (= v1 (cp v))
        (sshuffle v)
        (for el in v do (if (== el (get v1 @idx))
        (= b false) break))
        (textout to: ss b)
    )

    (processRes "typedef" (str ss) check)
)
}
