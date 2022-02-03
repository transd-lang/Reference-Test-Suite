/*This file is a part of Transd reference test suit.

  Test of type traits.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


MainModule: {
import: "tests",
ss: StringStream(),
check: "255 0 254",

_start: (λ (with a Byte() (= a 255) (textout to: ss a " ") (+= a 1)
                (textout to: ss a " ") (textout to: ss (- a 2))
            )
    (processRes "byte" (str ss) check)
)
}
