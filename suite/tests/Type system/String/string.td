/*This file is a part of Transd reference test suit.

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
a b cd а б вг A b Cd А б Вг A B CD А Б ВГ
qqq 3 21 3 19
aaa baaa aaaA aaaaaa
1 1",
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

    tst-setel: (λ locals: ss StringStream() s "abc"
        (textout to: ss (set-el s 1 "B") " ")
        (textout to: ss s " ")
        (textout to: ss (set-el (cp s) 0 "Q") " ")
        (textout to: ss s)
        (if (eq (str ss) "aBc aBc QBc aBc") (ret "1") else (ret (str ss)))
    ),

    tst-sub: (λ locals: ss StringStream() s "abc def ghi jkl"
        (textout to: ss (sub s 12) " " (sub s 4 7))
        (if (eq (str ss) "jkl def") (ret "1") else (ret (str ss)))
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
        (textout to: ss :boolalpha 
                    (fst (eval "(reverse Range(in: s 2 -2))")) " ")
        (lout to: ss "")

        //-- (sort)
        (with const s "CвВB1$a)Аа@2Aб3Бbc#("
            (tst-sort s)
            (tst-sort String(Range(in: s 4 -4)))
            (textout to: ss (fst (eval "(sort Range(in: s 4 -4))")) " ")
        )
        (lout to: ss "")

        // (front), (back)
        (with s "abcde"
	        (textout to: ss (front s) (back s) (clear s) " "
                (fst (eval "(front s)")) " " (fst (eval "(back s)")) "\n")
        )

        // (tolower), (toupper)
        (with s "A b Cd А б Вг" 
            (textout to: ss (tolower s) " " s " " (toupper s))
        )
        (lout to: ss "")

        // (strip)
        (with s "\t\r\n   \n\r qqq\n\r \r\t\t\n \t" q ""
            (textout to: ss (strip (= q s)) " " (size q))
            (textout to: ss " " (size s))
            (strip (= q s) " \r\t\n" )
            (textout  to: ss " " (size q))
            (strip (= q s) "\t\r " " ")
            (textout to: ss " " (size q))
        )
        (lout to: ss "")

        // (replace)
        (with s "AAA bAAA AAAA AAAAAA" 
            (textout to: ss (replace s "AAA" "aaa"))
        )
        (lout to: ss "")

        // (sub)
        (textout to: ss (tst-sub))
        (textout to: ss " ")

        // (set-el)
        (textout to: ss (tst-setel))

        (processRes "string" (str ss) check)
    )
}
