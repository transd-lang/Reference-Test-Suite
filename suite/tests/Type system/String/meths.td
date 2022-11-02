/***
 This file is part of the reference test suit of Transd programming language.
 File:          meths.td
 Created:       Wed, 02 Nov 2022 09:29
 Last edited:   Wed, 02 Nov 2022 09:44
 Abstract: String methods.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
import: "tests",

tst_indexOf: (λ locals: ss StringStream()
    s "aaa bbb ccc ddd"  rs "aaa bbb ccc ddd aaa ccc"
    (textout to: ss
        (index-of s "ccc eee") " " (index-of s "ccc ") " "
        (index-of s "aaa" 1) " " (index-of rs :rev "ccc") " "
        (index-of rs :rev "ccc" -4) " " (index-of rs :rev "aaa" 17))
        (if (neq (str ss) "-1 8 -1 20 8 16") (throw (+ "indexOf: " (str ss))))
),
    
_start: (λ locals: check "OK"
    (try (tst_indexOf)
    (catch (= check (str @ex))))

    (processRes "meths" check "OK")
)
}
