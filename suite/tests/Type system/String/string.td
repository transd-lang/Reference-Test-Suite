/*This file is a part of Tourbillon compiler test suit.

  String built-in type operations.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: 
"8 test string
a \"abcdеёжз\" b 8 -1 зжёеdcba ёеdc false 
#$()123@ABCabcАБВабв $)123@AaАБаб false 
ae false false
a b cd а б вг A b Cd А б Вг A B CD А Б ВГ",
    const s: "abcdеёжз",

    ctor: (λ const s String()
        (textout to: ss String("test" " string\n"))
        (textout to: ss String("a \"" s "\" b "))
    ),

    tst-find-FNO: (λ const cont String() const chars String()
        (textout to: ss (find-first-not-of cont chars) " ")
    ),
    
    tst-reverse: (λ const cont String()
        (textout to: ss (reverse (cp cont)) " ")
    ),

    tst-sort: (λ const cont String()
        (textout to: ss (sort (cp cont)) " ")
    ),

    _start: (λ 
        //-- (size)
        (textout to: ss (size s) " ")

        //-- (ctor)
        (ctor s)

        //-- (find-first-not-of)
        (with const s "123.;\"\'!a.2bcd?!\'\"12" 
            const ch "1234567890\'\".;!?"
            const ch1 "abcd1234567890\'\".;!?"
            (tst-find-FNO s ch) (tst-find-FNO s ch1)
        )

        //-- (reverse)
        (tst-reverse s)
        (tst-reverse String(Range(in: s 2 -2)))
        (textout to: ss (fst (eval "(reverse Range(in: s 2 -2))")) " ")
        (lout to: ss "")

        //-- (sort)
        (with const s "CвВB1$a)Аа@2Aб3Бbc#("
            (tst-sort s)
            (tst-sort String(Range(in: s 4 -4)))
            (textout to: ss (fst (eval "(sort Range(in: s 4 -4))")) " ")
        )
        (lout to: ss "")

        (with s "abcde"
	        (textout to: ss (front s) (back s) (clear s) " "
                (fst (eval "(front s)")) " " (fst (eval "(back s)")) "\n")
        )
        (with s "A b Cd А б Вг" 
            (textout to: ss (tolower s) " " s " " (toupper s))
        )

        (processRes "string" (str ss) check)
    )
}
