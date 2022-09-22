/***
 This file is part of the reference test suit of Transd programming language.
 File:          Word_frequency.td
 Created:       Thu, 22 Sep 2022 11:36
 Last edited:   Thu, 22 Sep 2022 00:55

 Abstract:
 Rosetta task "Word frequency": 
 https://rosettacode.org/wiki/Word_frequency#Transd
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
import: "tests",
txtfile: "../../res/wordfreq.res",
ss: StringStream(),
check: "String the:96, of:56, and:44, on:20, we:19, a:18, ",

_start: (λ locals: cnt 0
    (with fs FileStream() words String()
          dir (substr @sourceFile from: 0 to: after: last: "/")
        (open-r fs (+ dir "/" txtfile))
        (textin fs words)

    (with v ( -|
        (split (tolower words))
        (group-by)
        (regroup-by (λ v Vector<String>() -> Int() (size v)))
        )
        (textout to: ss (_META_type (get (get (get v 1) 0) 0)) " ")
        (for i in v :rev do 
            (textout to: ss (get (get (snd i) 0) 0) ":" (fst i) ", ")
            (+= cnt 1) (if (> cnt 5) break))
    ))
    (processRes "Word_frequency" (str ss) check)
)
}

