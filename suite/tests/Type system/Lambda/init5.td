/***
 This file is part of the reference test suit of Transd programming language.
 File:          init5.td
 Created:       Tue, 06 Sep 2022 04:10
 Last edited:   Tue, 06 Sep 2022 05:07
 Abstract: Issue #11: Name resolution for scoped lambda objects.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
import: "tests",
ss: StringStream(),
check: "0 11 22 ",


_start: (λ
    (for i in Range(3) do
        (with la Lambda<ULong Int>(λ [[i]] p ULong()
                    (ret (+ i p)))
            (textout to: ss (exec la (* i 10)) " "))
    )
    (processRes "init5" (str ss) check)
)
}
