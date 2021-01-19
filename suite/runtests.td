/* This file is a part of Tourbillon compiler test suite.
 
   This is a driver of the testing process.
   To start tests, run this file with a program containing Tourbillon
   virtual compiler, e.g. frend:
   
   $ frend runtests.td
 */
#lang transd

Require : { searchDirs: ["."], packages: ["tests"] }


MainModule : {
    import: "tests",
	dir: Directory(),
    patt:  ".*\\.td",
	_start: (λ 
        (if (> @num_args 1) (set patt @1))
        (read dir "tests" patt) 
		(textout "Tests started: \n")
		(through (files dir) with el 
            (load-file el)
            (with modname (substr el from after last "/" to last ".")
                (import-module modname)
                (eval String(modname "::_start")))
		)
        (textout "Successful tests: " oktests "\n")
        (textout "Failed tests: " failtests)
	)
}
