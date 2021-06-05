/*This file is a part of Tourbillon compiler test suit.

  A test of 'with' form.
*/
#lang transd

Require : { searchDirs: [".."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "156",
    succ: false,
    a : 5,
    _start: (λ 
        (with b 1 (textout to: ss b))
        (with b a (textout to: ss b))
        (with b (+ a 1) (textout to: ss b))

        (processRes "with" check (str ss))
    )
}
