/*This file is a part of Tourbillon compiler test suit.

    A test of 'eval' form.
*/

#lang transd

Require : { searchDirs: [".."], packages: ["tests"] }

/*AssemblyDescription : {
    entryPoint : "eval::_start"
}*/

eval : {
    import: "tests",
    ss: StringStream(),
    check: "2",
    succ: false,
    str: "\\aaa\\bbb\\ccc\\ddd\\(textout to ss (+ 1 .eee",

	_start: (λ 
        (if verbose (textout " Testing 'eval'..." ))

        (with code (substr str from after last "\\" to last ".")
            (eval String(code "1))")))

    (if (eq check (str ss)) (set succ true) (+= oktests 1)
        else (+= failtests 1))

        (textout (if succ (if verbose " OK\n" else ".")
            else String("\n  'eval' FAILED: " ss "\n")
            ))
		)
}
