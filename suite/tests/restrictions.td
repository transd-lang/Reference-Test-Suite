/*This file is a part of Transd reference test suit.

  A test of 'with' form.
*/
#lang transd

Require : { searchDirs: [".."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "current security restrictions\n",
    _start: (λ 
        (with fname String( 
            (substr @sourceFile from: 0 to: after: last: "/") "restrictions1.td1")
        (textout to: ss (run-file fname)))

        (processRes "restrictions" (str ss) check)
    )
}
