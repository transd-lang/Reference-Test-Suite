/*This file is a part of Tourbillon compiler test suit.

*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: "UT[4, Be, Beryllium]
UT[5, B, Boron]
UT[2, He, Helium]
UT[1, H, Hydrogen]
UT[3, Li, Lithium]
-----
UT[1, H, Hydrogen]
UT[2, He, Helium]
UT[7, N, Nitrogen]
UT[8, O, Oxygen]
UT[9, F, Fluorine]
UT[10, Ne, Neon]
UT[17, Cl, Chlorine]
UT[18, Ar, Argon]
UT[36, Kr, Krypton]
UT[54, Xe, Xenon]
UT[86, Rn, Radon]
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

            (with rows (tsd-query tabl 
                select: ["Atomic number","Symbol","Name"]
                as: [[Int(),String(),String()]]
                where: "\"Atomic number\" < 6"
                sortby: "Name")
                (for row in rows do (lout to: ss row)))
    (lout to: ss "-----")

            (with rows (tsd-query tabl 
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
