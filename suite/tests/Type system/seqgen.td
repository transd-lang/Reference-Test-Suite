/*This file is a part of Transd reference test suit.

  Test of sequence generator.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }


MainModule: {
import: "tests",
ss: StringStream(),
check: "1 4 9 16 25 36 49 64 81 100 ",

// Rosetta task "100 doors"
100doors : (λ
    (with doors Vector<Bool>(100)
        (for i in Seq(100) do
            (for k in Seq(i 100 (+ i 1)) do
                (set-el doors k (not (get doors k)))
        ))

        (for i in Seq(100) do
            (if (get doors i) (textout to: ss (+ i 1) " "))
    ))
),


_start: (λ 
    (100doors) 

    (processRes "seqgen" (str ss) check)
)
}
