/*This file is a part of Transd reference test suit.

    Index: a complex test. 
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule : {
import: "tests",
ss: StringStream(),
check: 
"[31, 32, 33, 34, 35]
[36, 37, 38, 39, 40]
[41, 42, 43, 44, 45]
[46, 47, 48, 49, 50]
",

pst: Index<String Vector<Int>>({
            "A":[1,2,3,4,5,6,7,8,9,10], 
            "B":[11,12,13,14,15,16,17,18,19,20]}),

padrow: Lambda<Vector<Int> Vector<Int>>(λ row Vector<Int>() 
     (ret (for i in row project (+ i 30)))
),

_start: (λ 
    (for el in pst do 
        (for i in Range(2) do (lout to: ss
(exec padrow Range(in: (snd el) (* 5 i) (+ (* 5 i) 5))))))
        (processRes "pad" (str ss) check)
)
}
