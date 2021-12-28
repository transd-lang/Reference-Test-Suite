/* This file is a part of Tourbillon compiler test suite.
 
   The program in this file is a driver of the testing process.
   It iterates over test files in subdirectories and successively
   runs them.
   
   To start tests, run this file with a program containing Tourbillon
   virtual compiler, e.g. TREE3:
   
   $ tree3 runtests.td

   A regex pattern, specifying a subset of test files to run, can be
   added to the program call:

   $ tree3 runtests.td -args <PATTERN>

   For example, the following command will only run tests from the 
   "TSD" subdirectory:

   $ tree3 runtests.td -args .*/TSD/.*\.td
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
        (if (> @numArgs 1) (set patt (get @progArgs 1)) (textout "patt: " patt "\n"))
        (while (< cnt (size dirs))
            (set d (get dirs cnt))
            (read dir d ".*") 
            (for d1 in (dirs dir) do
                (if (not (match d1 ".*/\\.\\.?"))
                    (append dirs d1)))
            (for f in (files dir) do
                (if (match f patt)
                    (load-file f)
                    (with modname "MainModule"
                        (import-module modname)
                        (if verbose (textout " Testing " 
                            width: 50 fill: "." :left                    
                            (substr f from: after: "suite/tests/") ))
                        (if (not (fst (eval String(modname "::_start"))))
                            (textout modname " FAILED!\n")
                            (+= failtests 1)
                        )
                        (unload-file-modules f)
            )))
            (+= cnt 1)
        )
        (textout "Successful tests: " oktests "\n")
        (textout "Failed tests: " failtests "\n")
    )
}
