/*This file is a part of Tourbillon compiler test suit.

  Rosetta task "Top-rank per group".
  Tuple operations and working with tables.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    tbl : String( 
`"Tyler Bennett",    "E10297",32000,"D101"
"John Rappl",           "E21437",47000,"D050"
"George Woltman",   "E00127",53500,"D101"
"Adam Smith",           "E63535",18000,"D202"
"Claire Buckman",   "E39876",27800,"D202"
"David McClellan","E04242",41500,"D101"
"Rich Holcomb",     "E01234",49500,"D202"
"Nathan Adams",     "E41298",21900,"D050"
"Richard Potter",   "E43128",15900,"D101"
"David Motsinger","E27002",19250,"D202"
"Tim Sampair",      "E03033",27000,"D101"
"Kim Arlich",           "E10001",57000,"D190"
"Timothy Grove",    "E16398",29900,"D190"`),

    ss: StringStream(),
    check: 
"[[John Rappl, E21437, 47000, D050]]
[[Nathan Adams, E41298, 21900, D050]]
[[George Woltman, E00127, 53500, D101]]
[[David McClellan, E04242, 41500, D101]]
[[Kim Arlich, E10001, 57000, D190]]
[[Timothy Grove, E16398, 29900, D190]]
[[Rich Holcomb, E01234, 49500, D202]]
[[Claire Buckman, E39876, 27800, D202]]
",
    succ: false,
    Record : typealias(Tuple<String String Int String>()),
    N: 2,
    curN: 0,
    dep: String(),
    deps: Index<String Int>(),
    _start: (λ 
    //(with recs Vector<Record>( :untypedTable tbl "," "\n" )
    (with recs Vector<Record>() res Vector<Record>()
        (load-table recs :untypedTable tbl "," "\n" )
        (sort Range(in: recs -1 0)
            (lambda l Record() r Record() -> Bool()
                (ret (less (get l 2) (get r 2)))))

        (for el in recs do 
            (= dep (get el 3))
            (= curN (snd (get-val deps dep 0)))
            (if (< curN N) (append res el) (set-el deps dep (+ curN 1)))
        )

        (sort res 
            (lambda l Record() r Record() -> Bool()
                (ret (less (get l 3) (get r 3)))))

        (for i in res do (textout to: ss i "\n"))

    )
    (processRes "uvector" (str ss) check)
)
}
