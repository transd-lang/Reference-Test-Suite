/*This file is a part of Tourbillon compiler test suit.

  TSDBase operations (Rosetta "Merge datasets" task).
  Testing UPDATE query.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",

tbl: `1001,Hopper
4004,Wirth
3003,Kemeny
2002,Gosling
5005,Kurtz`,

tbl1: `
2002,2020-09-10,6.8
1001,2020-09-17,5.5
4004,2020-09-24,8.4
2002,2020-10-08,
1001,,6.6
3003,2020-11-12,
4004,2020-11-05,7.0
1001,2020-11-19,5.3`,

cols: `@key_PATIENT_ID:Int,
        LASTNAME:String,
        VISIT_DATE:DateTime,
        SCORE:Double,
        SCORE_AVG:Double,
        NUM_VISITS:Int`,

Record : typealias(Tuple<Int DateTime Double>()),

    ss: StringStream(),
    check: 
"PATIENT_ID|  LASTNAME|VISIT_DATE|     SCORE| SCORE_AVG|
      1001|    Hopper|2020-11-19|      17.4|       5.8|
      2002|   Gosling|2020-10-08|       6.8|       3.4|
      3003|    Kemeny|2020-11-12|         0|         0|
      4004|     Wirth|2020-11-05|      15.4|       7.7|
      5005|     Kurtz|          |         0|         0|
",
    _start: (λ 
    (with base TSDBase()
		(load-table base tbl colNames: cols)
        (build-index base "PATIENT_ID")

        (with vizs Vector<Record>() 
            (load-table vizs tbl1 :mixedTypes fieldSep: "," rowSep: "\n" )
            (for viz in vizs do
                (tsd-query base 
                    :update set:
                (lambda PATIENT_ID Int() VISIT_DATE DateTime() 
                        SCORE Double() SCORE_AVG Double() NUM_VISITS Int()
                    (+= NUM_VISITS 1)
                    (set VISIT_DATE (get viz 1)) 
                    (set SCORE (+ SCORE (get viz 2)))
                    (set SCORE_AVG (/ SCORE NUM_VISITS)))
            satisfying: (lambda PATIENT_ID Int() (eq PATIENT_ID (get viz 0))))
            ))
        
        (with cols ["PATIENT_ID","LASTNAME","VISIT_DATE","SCORE","SCORE_AVG"]
        (with recs (tsd-query base select: cols 
                as: [[Int(), String(), DateTime(), Double(), Double()]]
                satisfying: (lambda PATIENT_ID Int() true)
                sortby: "PATIENT_ID"
                )
                (for i in cols do (textout to: ss width: 10 i "|")) (lout to: ss "")
                (for rec in recs do 
                    (for-each rec (λ i :Data() (textout to: ss width: 10 i "|" )))
                    (lout to: ss ""))
		)))

    (processRes "tsdbase" (str ss) check)
)
}
