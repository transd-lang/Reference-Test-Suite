/*This file is a part of Tourbillon compiler test suit.

  File system operations.
*/
#lang transd

Require : { searchDirs: [".."], packages: ["tests"] }

MainModule : {
    import: "tests",
    dir: Directory(),
    tstdir: "../res/filestest",
    dirs: Vector<String>(),
    patt:  ".*\\.ext2",
    ss: StringStream(),
    check: "res/filestest/file2.ext2
res/filestest/dir1/file2.ext2
res/filestest/dir2/file2.ext2
",

    _start: (λ 
    (with rootdir (substr @sourceFile from: 0 to: after: last: "/")
        cnt 0 d ""
        (set tstdir (+ rootdir tstdir)) 
        (append dirs tstdir)
        //(for d in dirs do 
        (while (< cnt (size dirs))
            (set d (get dirs cnt))
            (read dir d ".*") 
            (for d1 in (dirs dir) do
                (if (not (match d1 ".*/\\.\\.?"))
                    (append dirs d1)))
            (for f in (files dir) do
                (if (match f patt)
                    (with relname (substr f (rfind f "res"))
                        (textout to: ss relname "\n"))
            ))
            (+= cnt 1)
        )
    )
    (processRes "files" (str ss) check)
)
}
