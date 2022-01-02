/*This file is a part of Tourbillon compiler test suit.

*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "[4, \"Be\", \"Beryllium\"]
[5, \"B\", \"Boron\"]
[2, \"He\", \"Helium\"]
[1, \"H\", \"Hydrogen\"]
[3, \"Li\", \"Lithium\"]
-----
[1, \"H\", \"Hydrogen\"]
[2, \"He\", \"Helium\"]
[7, \"N\", \"Nitrogen\"]
[8, \"O\", \"Oxygen\"]
[9, \"F\", \"Fluorine\"]
[10, \"Ne\", \"Neon\"]
[17, \"Cl\", \"Chlorine\"]
[18, \"Ar\", \"Argon\"]
[36, \"Kr\", \"Krypton\"]
[54, \"Xe\", \"Xenon\"]
[86, \"Rn\", \"Radon\"]
",
    tabfile: "../../res/db/periodic_table.csv",
    tabstr: "",

    _start: (λ 
        (with rootdir (substr @sourceFile from: 0 to: after: last: "/")
            (= tabfile String( rootdir tabfile)))

        (with fs FileStream()
            (open-r fs tabfile) (textin from: fs tabstr)
        )
        (with tabl Table()
            (load-table tabl tabstr :firstRowColNames)
            (build-index tabl "Atomic number")
            (build-index tabl "Phase at r.t.")

            (with rows (tsd tabl 
                select: ["Atomic number","Symbol","Name"]
                as: [[Int(),String(),String()]]
                where: "\"Atomic number\" < 6"
                sortby: "Name")
                (for row in rows do (lout to: ss row)))
    (lout to: ss "-----")

            (with rows (tsd tabl 
                select: ["Atomic number","Symbol","Name"]
                as: [[Int(),String(),String()]]
                where: "\"Phase at r.t.\" == \"gas\""
                sortby: "Atomic number")
                (for row in rows do (lout to: ss row))
                )

        )
    (processRes "tabletst" (str ss) check)
    )
}
