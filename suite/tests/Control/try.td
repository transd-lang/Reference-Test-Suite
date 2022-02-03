/*This file is a part of Transd reference test suit.

  A test of the "try...catch" construction and exception handling.*/

#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule : {
    import: "tests",
	check: "before try; before while; OK 10; OK 11; OK 12; fail; after try.",
	ss: StringStream(),

	funcF: (lambda i Int() 
        (if (!= i 13) 
            (textout to: ss "OK " i "; ") 
        else 
            (throw "fail; "))),

	func1: (lambda 
        (textout to: ss "before try; ")
        (try 
            (textout to: ss "before while; ")
            (with n 10
                (while (< n 15) 
                    (funcF n)(+= n 1)
                )
            )
            (textout to: ss "after while; ")
            (catch (textout to: ss (str @ex)))
        )
        (textout to: ss "after try.")
    ),
	_start: (lambda 
        (func1)

        (processRes "try" (str ss) check)
    )
}
