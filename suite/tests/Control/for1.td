/*This file is a part of Transd reference test suit.

    http://rosettacode.org/wiki/Department_numbers
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule : {
    import: "tests",
    ss: StringStream(),
    check:
"2 3 7
2 4 6
2 6 4
2 7 3
4 1 7
4 2 6
4 3 5
4 5 3
4 6 2
4 7 1
6 1 5
6 2 4
6 4 2
6 5 1
",

	_start: (lambda 
        (for i in Range(1 8) where (not (mod i 2)) do
            (for j in Range(1 8) where (neq i j) do
                (for k in Range(1 8) where (and (neq i k) (neq j k)) do
           (if (eq (+ i j k) 12) (lout to: ss i " " j " " k)))))

        (processRes "for1" check (str ss))
    )
}
