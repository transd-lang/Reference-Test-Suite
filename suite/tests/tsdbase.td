/*This file is a part of Tourbillon compiler test suit.

  TSDBase operations (Rosetta task "Top-rank per group").
  Testing building database, creating index, table manipulations 
    and TSD queries.
*/
#lang transd

Require : { searchDirs: [".."], packages: ["tests"] }

tsdbase: {
    import: "tests",
    tbl : String( 
`EmployeeName,@key_EmployeeID,Salary,Department
"Tyler Bennett",    "E10297",32000,"D101"
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
"UT[D050, E21437, John Rappl, 47000]
UT[D050, E41298, Nathan Adams, 21900]
UT[D101, E00127, George Woltman, 53500]
UT[D101, E04242, David McClellan, 41500]
UT[D190, E10001, Kim Arlich, 57000]
UT[D190, E16398, Timothy Grove, 29900]
UT[D202, E01234, Rich Holcomb, 49500]
UT[D202, E39876, Claire Buckman, 27800]
",
    succ: false,
    N: 2,
    _start: (λ 
    (if verbose (textout " Testing 'tsdbase'..." ))

    (with base TSDBase()
        (load-table base tbl)
        (build-index base "Department")
        (with rows (tsd-query base select ["Department"] distinct sortby "Department")
            (for row in rows do
                (with recs (tsd-query base select all 
    where (lambda Department String() (eq Department (get row 0))) 
                    sortby "Salary" desc limit N)
                (for rec in recs do (textout to ss rec "\n"))
        )))
    )
    (processRes "tsdbase" check (str ss))
)
}
