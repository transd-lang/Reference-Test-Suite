/* This file is a part of Tourbillon compiler test suite.
 
   This file is a driver of the testing process.
   To start tests, run this file with a program containing Tourbillon
   virtual compiler, e.g. frend:
   
   $ frend runtests.td
 */
#lang transd

Require : { searchDirs: ["."], packages: ["tests"] }

AssemblyDescription : {
    entryPoint : "RunTests::_start"
}

RunTests : {
    import: "tests",
    dir: Directory(),
    dirs: ["tests"],
    patt:  ".*\\.td",
    cnt: 0,
    d: "",
    _start: (λ 
        (textout "Tests started: \n")
        //(if (> @num_args 1) (set patt @1) (textout "patt: " patt "\n"))
        (if (> @numArgs 1) (set patt (get @progArgs 0)) (textout "patt: " patt "\n"))
        //(for d in dirs do
        (while (< cnt (size dirs))
            (set d (get dirs cnt))
            (read dir d ".*") 
            (for d1 in (dirs dir) do
                (if (not (match d1 ".*/\\.\\.?"))
                    (append dirs d1)))
            (for f in (files dir) do
                (if (match f patt)
                    (load-file f)
                    //(with modname (substr f from: after: last: "/" to: last: ".")
                    (with modname "MainModule"
                        (import-module modname)
                        (if verbose (textout " Testing " 
                            (substr f from: after: "suite/tests/") ))
                        (if (not (eval String(modname "::_start")))
                            (textout modname " FAILED!\n")
                            (+= failtests 1)
                        )
                        //(unload-module modname)
                        (unload-file-modules f)
            )))
            (+= cnt 1)
        )
        (textout "Successful tests: " oktests "\n")
        (textout "Failed tests: " failtests "\n")
    )
}
