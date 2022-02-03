/*This file is a part of Transd reference test suit.

  Test of type traits.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


MainModule: {
import: "tests",
ss: StringStream(),
check: "3671 ",

_start: (λ (with d 0.0 s "01:01:11"
            (with v (split s ":")
                (+= d (* 3600 Int((get v 0))) 
                        (* 60 Int((get v 1)))
                        Int((get v 2)))
            )
            (textout to: ss d " ")
           )
    (processRes "double" (str ss) check)
)
}
