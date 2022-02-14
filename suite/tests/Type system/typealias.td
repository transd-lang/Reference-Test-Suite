/*This file is a part of Transd reference test suit.

  'TypeAlias' module and 'typealias' statement.

'typealias' statement is used for declaring a new type name which is
a synonim (alias) to some another type name. The new type name can be used
everywhere, where the original type name can be used. Type aliases created
in a usual module are valid only within that module. For global aliases
the 'TypeAlias' module should be used.

'TypeAlias' module is used for defining program-wide type aliases. It can
contain one or more 'typealias' statements.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

TypeAlias : {
    Vi: typealias(Vector<Int>())
}

mod1 : {
    import: "MainModule",
    v: Vi([1,2,3,4,5]),

    func1: (λ (lout to: ss v))
}

MainModule: {
    import: "tests",
    import: "mod1",
    ss: StringStream(),
    check: "[\"a\", \"b\"]
[1, 2, 3, 4, 5]
",

    Vs: typealias(Vector<String>()),

    vs: Vs(["a","b"]),

    access allow: { ss : ["mod1"] },

    _start: (λ 
        (lout to: ss vs)
        (func1)
        (processRes "typealias" (str ss) check)
    )
    
}
