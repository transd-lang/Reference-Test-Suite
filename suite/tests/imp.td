/*This file is a part of Tourbillon compiler test suit.

  Accessing a shared variable from two modules.
  Testing 'load-file', 'import-module', 'eval' forms.
*/

#lang transd

Require : { searchDirs: ["../res", '..'], packages: ["module1", "tests"] }

AssemblyDescription : {
    entryPoint : "imp::_start"
}

imp: {
    import: "tests",
    import: "module1",
    modname: "module2",
    succ: false,
    
    _start: (λ 
        (if verbose (textout " Testing 'imp'..." ))

        (load-file String("res/" modname ".td"))
        (import-module modname)
        (= sharedInt 5)
        (eval String(modname "::_start"))

        (if (eq sharedInt 7) (set succ true) (+= oktests 1)
        else (+= failtests 1))
        (textout (if succ (if verbose " OK\n" else ".")
            else String("\n  'imp' FAILED: \n")
            ))
    )
}
