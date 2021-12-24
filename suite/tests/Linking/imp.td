/*This file is a part of Tourbillon compiler test suit.

  Accessing a shared variable from two modules.
  Testing 'load-file', 'import-module', 'eval' forms.
*/

#lang transd

Require : { searchDirs: ["../../res", '../..'], packages: ["module1", "tests"] }

MainModule: {
    import: "tests",
    import: "module1",
    modname: "module2",
    ss: StringStream(),
    check: "7",
    
    _start: (λ 
        (with rootdir (substr @sourceFile from: 0 to: after: last: "/")
            (load-file String( rootdir "../../res/" modname ".td")))
        (import-module modname)
        (= sharedInt 5)
        (eval String(modname "::_start"))
        (textout to: ss sharedInt)

        (processRes "imp" check (str ss))

        /*(if (eq sharedInt 7) (set succ true) (+= oktests 1)
        else (+= failtests 1))
        (textout (if succ (if verbose " OK\n" else ".")
            else String("\n  'imp' FAILED: \n")
            ))*/
    )
}
