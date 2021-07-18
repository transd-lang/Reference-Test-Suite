/*This file is a part of Tourbillon compiler test suit.

  Rosetta task "AKS test for primes" :
  http://rosettacode.org/wiki/AKS_test_for_primes#Transd

*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "(x - 1)^12 = +1x^0 -12x^1 +66x^2 -220x^3 +495x^4 -792x^5 +924x^6 -792x^7 +495x^8 -220x^9 +66x^10 -12x^11 +1x^12 
2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 ",

    poly: (λ n Long()
        (with v Vector<Long>([1])
            (for i in Range(n) do
                (append v (/ (* (get v -1) (- (- n i))) (to-Long (+ i 1))))
            )
            (reverse v)
            (ret v)
        )
    ),

    aks_test: (λ n Long() -> Bool()
        (if (< n 2) (ret false))
        (with v (poly n)
            (set-el v 0 (+ (get v 0) 1))
            (ret (not (any Range(in: v 0 -1) (λ (mod @it n)))))
        )
    ),

    _start: (λ 
    (with v Vector<Long>()
            (set v (poly 12))
            (textout to: ss "(x - 1)^" 12 " = ")
            (for i in v do (textout to: ss :sign i "x^" :nosign @idx " "))
            (textout to: ss "\n")
        (for p in Seq( 2 62 ) do
            (if (aks_test p) (textout to: ss p " "))
        )
    )
        (processRes "AKS_primes" (str ss) check)
    )
}

