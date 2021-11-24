/*
 * Performance test: loading a table with 100,000 rows and
 * performing a data query on it.
 */
#lang transd


MainModule: {
    tabfile: "/mnt/dnl/100000-Records.csv",
    tabstr: "",
    dt: DateTime(),

    _start: (λ 
        (lout "Loading database...")
        (set-now dt)
        (with fs FileStream()
            (open fs tabfile) (textin tabstr fs)
        )
        (with tabl Table()
            (load-table tabl tabstr)
            (lout (now-delta dt) " sec. elapsed")
            (lout "Building indexes...")
            (set-now dt)
            (build-index tabl "Age in Company (Years)")
            (build-index tabl "Salary")

            (lout (now-delta dt) " sec. elapsed")
            (lout "Perfoming query...")
            (set-now dt)

            (with rows (tsd-query tabl 
                    select: ["Name Prefix", "First Name", "Last Name",
                             "Age in Company (Years)", "Salary"]
                    as: [[String(),String(),String(),Double(),Int()]]
                    where: "\"Age in Company (Years)\" > 35.0 AND 
                        Salary < 43000"
                    sortby: "Salary")
                (lout (now-delta dt) " sec. elapsed")
                (for row in rows do (lout row)))
        )
    )
}
