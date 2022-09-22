/* This file is a part of Transd reference test suite.
 
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
    modname: "MainModule",
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
                    (import-module modname)
                    (if verbose (textout " Testing " 
                        width: 50 fill: "." :left                    
                        (substr f from: after: "suite/tests/") ))
                    (if (not (fst (eval String(modname "::_start"))))
                        (textout modname " FAILED!\n")
                        (+= failtests 1)
                    )
                    (unload-file-modules f)
            ))
            (+= cnt 1)
        )
        (textout "Successful tests: " oktests "\n")
        (textout "Failed tests: " failtests "\n")
    )
}

/*
    Transd code example.
    --------------------

This code can serve as an example of traversing a directory tree and working with
files. The driver program recursively lists the contents of subdirectories and
selects Transd source files based on file name pattern. For each selected file
it performs the following:

  1. Loads this file's contents into the program's assembly;
  2. Imports the "MainModule" module into program's namespace;
  3. Evaluates the module's "_start" function;
  4. Checks the result and reports if needed;
  5. Unloads the file and the module from program's assembly.

Notes. 

Instead of loading the test file into program's namespace we could just run it with
'(run-file f)' function and check the STD output. We load it, instead, for richer or 
simpler communication via shared data structures in the common namespace.
Via STD output we would either return just OK or FAIL, or, for more informative
output, we would need first encode it in the test file, and then decode in the driver.

By loading the file, we enable the test case to communicate with the driver directly via
shared variables in the "tests" module. Currently, it's only one 'oktests' variable,
but in the future this may change.

*/
