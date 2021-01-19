/*This file is a part of Tourbillon compiler test suit.

  A test of 'with' form.
*/
#lang transd

Require : { searchDirs: [".."], packages: ["tests"] }

/*AssemblyDescription:{
    entryPoint: "with::_start"
}*/

with: {
    import: "tests",
    ss: StringStream(),
    check: "156",
    succ: false,
    a : 5,
    _start: (λ 
        (if verbose (textout " Testing 'with'..." ))

        (with b 1 (textout to ss b))
        (with b a (textout to ss b))
        (with b (+ a 1) (textout to ss b))

        (if (eq check (str ss)) (set succ true) (+= oktests 1)
        else (+= failtests 1))
        (textout (if succ (if verbose " OK\n" else ".")
            else String("\n  'with' FAILED: " ss "\n")
            ))
    )
}
