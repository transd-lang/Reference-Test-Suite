/* Transd Programming Language
 * ---------------------------
 *
 * Performance benchmark 
 *
 * Data query on a Table
 *
 * 1. Read a file with tabular data into 'tabstr:String'
 *    object.
 * 2. Initialize the 'tabl:Table' object with the data
 *    from 'tabstr'.
 * 3. Build indexes on the columns which will be used
 *    as the selection attributes in a SELECT query.
 * 4. Perform a SELECT query on the table, and save the
 *    results to 'rows:Vector<Tuple...>'  object.
 * 5. Print the query results to the screen.
 */
#lang transd


MainModule: {
    tabfile: "/mnt/vault/dnl/100000-Records.csv",
    tabstr: "",
    dt: DateTime(),

    _start: (λ 
        (lout "Loading database...")
        (set-now dt)
        (with fs FileStream()
            (open-r fs tabfile) (textin from: fs tabstr)
        )
        (with tabl Table()
            (load-table tabl tabstr :firstRowColNames)
            (lout (now-delta dt) " sec. elapsed")
            (lout "Building indexes...")
            (set-now dt)
            (build-index tabl "Age in Company (Years)")
            (build-index tabl "Salary")

            (lout (now-delta dt) " sec. elapsed")
            (lout "Perfoming query...")
            (set-now dt)

            (with rows (tql tabl 
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
