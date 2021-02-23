/* This file is a part of Tourbillon compiler test suite.
 
   This file is a driver of the testing process.
   To start tests, run this file with a program containing Tourbillon
   virtual compiler, e.g. frend:
   
   $ frend runtests.td
 */
#lang transd

Require : { searchDirs: ["."], packages: ["tests"] }


MainModule : {
    import: "tests",
    dir: Directory(),
    dirs: ["tests"],
    patt:  ".*\\.td",
    _start: (λ 
        (textout "Tests started: \n")
        (if (> @num_args 1) (set patt @1))
        (for d in dirs do
            (read dir d ".*") 
            (for d1 in (dirs dir) do
                (if (not (match d1 ".*/\\.\\."))
                    (add dirs d1)))
            (for f in (files dir) do
                (if (match f patt)
                    (load-file f)
                    (with modname (substr f from after last "/" to last ".")
                        (import-module modname)
                        (eval String(modname "::_start")))))
        )
        (textout "Successful tests: " oktests "\n")
        (textout "Failed tests: " failtests)
    )
}
