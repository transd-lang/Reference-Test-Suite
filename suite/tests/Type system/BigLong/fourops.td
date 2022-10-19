/***
 This file is part of the reference test suit of Transd programming language.
 File:          fourops.td
 Created:       Mon, 17 Oct 2022 15:55
 Last edited:   Wed, 19 Oct 2022 18:37
 Abstract: Four arithmetic operations.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

TypeAlias: {
    BL: typealias(BigLong)
}

MainModule: {
import: "tests",
two: BL(2),

tst_add: (λ locals: res BL(0)
    (= res (+ BL("1") 1))
    (if (neq res 2) (throw "tst_add1"))
    (= res (+ BL("0") 0))
    (if (neq res 0) (throw "tst_add2"))
    (= res (+ BL((pow two 63)) -1))
    (if (neq res "9223372036854775807") (throw "tst_add3"))
    (= res (+ BL((pow two 63)) 1))
    (if (neq res "9223372036854775809") (throw "tst_add4"))
    (= res (+ BL((pow two 63)) (pow 2 62)))
    (if (neq res "13835058055282163712") (throw "tst_add5"))
    (= res (+ BL((pow two 67)) (- BL((pow two 65)))))
    (if (neq res "110680464442257309696") (throw "tst_add6"))
),

tst_sub: (λ locals: res BL(0)
    (= res (- BL("1") 2))
    (if (neq res -1) (throw "tst_sub1"))
    (= res (- BL("0") 0))
    (if (neq res 0) (throw "tst_sub2"))
    (= res (- BL((- (pow two 63))) -1))
    (if (neq res "-9223372036854775807") (throw "tst_sub3"))
    (= res (- BL((- (pow two 63))) 1))
    (if (neq res "-9223372036854775809") (throw "tst_sub4"))
    (= res (- BL((- (pow two 63))) (pow 2 62)))
    (if (neq res "-13835058055282163712") (throw "tst_sub5"))
    (= res (- BL((- (pow two 67))) BL((- (pow two 65)))))
    (if (neq res "-110680464442257309696") (throw String( "tst_sub6: " res)))
    (= res (- BL((- (pow two 67))) BL((pow two 65))))
    (if (neq res "-184467440737095516160") (throw "tst_sub7"))
),

tst_mul: (λ locals: res BL(0)
    (= res (* BL(0) 0))
    (if (neq res 0) (throw "tst_mul1"))
    (= res (* BL(1) 0))
    (if (neq res 0) (throw "tst_mul2"))
    (= res (* BL(-1) 123456789))
    (if (neq res -123456789) (throw "tst_mul3"))
    (= res (* BL((pow 2 32)) (pow 2 32)))
    (if (neq res BL((pow two 64))) (throw "tst_mul4"))
),

tst_div: (λ locals: res BL(0)
    (= res (/ two 1))
    (if (neq res 2) (throw "tst_div1"))
    (= res (/ two 2))
    (if (neq res 1) (throw "tst_div2"))
    (= res (/ BL(100) -2))
    (if (neq res -50) (throw "tst_div3"))
    (= res (/ BL((pow two 64)) (pow 2 32)))
    (if (neq res BL((pow 2 32))) (throw "tst_div4"))

),

_start: (λ locals: check "OK"
(try
    (tst_add)
    (tst_sub)
    (tst_mul)
    (tst_div)
(catch (= check (str @ex))))

    (processRes "fourops" check "OK")
)
}
