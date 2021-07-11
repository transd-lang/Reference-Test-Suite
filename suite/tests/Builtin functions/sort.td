/*This file is a part of Tourbillon compiler test suit.

  A test of '(sort ...)' form.*/

#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    vint: [43, 25, 127, 0, -43],
    vstr : ["ca", "ab", "aa", "Aa", "aBa", "aba", "bb", "bab", "BC", "Caa" ],
    ss: StringStream(),
    check: "[-43, 0, 25, 43, 127] [127, 43, 25, 0, -43] [Aa, BC, Caa, aBa, aa, ab, aba, bab, bb, ca] [ca, bb, bab, aba, ab, aa, aBa, Caa, BC, Aa] [aa, Aa, ab, aba, aBa, bab, bb, BC, ca, Caa] [Caa, ca, BC, bb, bab, aba, aBa, ab, aa, Aa]",
    succ: false,
    
    _start: (λ 
        (textout to: ss (sort vint) " ") 
        (textout to: ss (sort Range(in: vint -0 0)) " ") 
        (textout to: ss (sort vstr) " ")
        (textout to: ss (sort Range(in: vstr -0 0)) " ")
        (sort vstr (lambda l String() r String() -> Bool()
          (ret (less (tolower l) (tolower r)))))
        (textout to: ss vstr " ")
        (sort Range(in: vstr -0 0) (lambda l String() r String() -> Bool()
          (ret (less (tolower l) (tolower r)))))
        (textout to: ss vstr)

        (processRes "sort" (str ss) check)
    )
}
