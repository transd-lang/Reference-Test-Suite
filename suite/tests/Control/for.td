/*This file is a part of Transd reference test suit.

  Test of loops and ranges.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    vec: [0,1,2,3],
    bigVec: [10,20,30,40,50,60,70,80,90,100],
    check: "0 1 2 3 
-10 -8 -6 -4 -2 0 2 4 6 8 
30 40 50 60 70 80 
10 30 50 70 90 ",

  _start: (λ 
    (for i in vec do
        (textout to: ss i " "))
    (textout to: ss :nl)
    (for i in Seq(-10 10 2) do
        (textout to: ss i " "))
    (textout to: ss :nl)
    (for i in Range(in: bigVec 2 -2) do
        (textout to: ss i " " ))
    (textout to: ss :nl)
    (with idx 0 (while (< idx 9)
         (textout to: ss (get bigVec idx) " ")
         (+= idx 2)
     ))
    (processRes "for" check (str ss))
  )
}
