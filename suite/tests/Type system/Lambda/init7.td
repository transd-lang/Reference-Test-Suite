/***
 File:          init7.td
 Created:       Fri, 23 Sep 2022 08:09
 Last edited:   Sun, 06 Nov 2022 16:19
 Abstract: Issue #16: locals initializers in lambda member objects.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }



MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "1 5 25 ",

    la: Lambda<Int Null>(λ i Int() 
        locals: b (* i 5) // <=
        (or (and (> i 0) (< i 30)) (throw))
        (textout to: ss i " ")
        (if (> b 100) (ret))
        (exec la b)
    ),
    _start: (λ 
        (exec la 1)
        (processRes "init7" (str ss) check)
    )
}
