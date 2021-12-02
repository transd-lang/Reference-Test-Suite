/*This file is a part of Tourbillon compiler test suit.

    A test of 'eval' form.

Test's script:

    A string with a Transd expression is constructed and then executed with
    the 'eval' function. 
*/

#lang transd

Require : { searchDirs: [".."], packages: ["tests"] }


MainModule : {
    import: "tests",
    ss: StringStream(),
    check: "2",
    str: "\\aaa\\bbb\\ccc\\ddd\\(textout to: ss (+ 1 .eee",

    _start: (λ 
        (with code (substr str from: after: last: "\\" to: last: ".")
            (eval String(code "1))")))

        (processRes "eval" check (str ss))
    )
}
