/*This file is a part of Transd reference test suit.

  Test of type traits.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }


MainModule: {
import: "tests",
ss: StringStream(),
check: "55",
i: 5,
d: Double(5.5),

intgr: (λ n :Number() (ret (to-Int n))),

_start: (λ (textout to: ss (intgr i)) // => 5
           (textout to: ss (intgr d)) // => 5

    (processRes "traits" (str ss) check)
)
}
