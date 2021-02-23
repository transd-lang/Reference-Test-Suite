/*This file is a part of Tourbillon compiler test suit.

  A test of the "try...catch" construction and exception handling.*/

#lang transd

Require : { searchDirs: [".."], packages: ["tests"] }

/*AssemblyDescription : {
    entryPoint : "try::_start"
}*/

try : {
    import: "tests",
	check: "before try; before while; OK 10; OK 11; OK 12; fail; after try.",
	ss: StringStream(),
    succ: false,

	funcF: (lambda i Int() 
        (if (!= i 13) 
            (textout to ss "OK " i "; ") 
        else 
            (throw "fail; "))),

	func1: (lambda 
        (textout to ss "before try; ")
        (try 
            (textout to ss "before while; ")
            (with n 10
                (while (< n 15) 
                    (funcF n)(+= n 1)
                )
            )
            (textout to ss "after while; ")
            (catch (textout to ss (str @ex)))
        )
        (textout to ss "after try.")
    ),
	_start: (lambda 
        (if verbose (textout " Testing 'try'..." ))
        
        (func1)

        (processRes "try" check (str ss))
    )
}
