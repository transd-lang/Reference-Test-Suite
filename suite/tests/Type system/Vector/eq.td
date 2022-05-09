/*This file is a part of Transd reference test suit.

  Testing the equality of vectors.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "1 0 1 0 ",

    _start: (λ 
        (with v [3,4,5]
            (textout to: ss (== v [3,4,5]) " ")
            (textout to: ss (== v [3,4,6]) " ")
        )

        (with v [3,4,5,6,7,8]
            (textout to: ss (== Range(in: v 0 3) [3,4,5]) " ")
            (textout to: ss (== Range(in: v 1 4) [3,4,5]) " ")
        )
        (processRes "vector:eq" (str ss) check)
    )
}
