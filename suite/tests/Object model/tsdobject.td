/*This file is a part of Tourbillon compiler test suit.

  Test of TSD objects.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

class Inner: {
    vec: Vector<String>(),
    ss: StringStream(),

    prep: (λ objs Index<String Vector<Object>>()
    ),
    work: (λ i Int() (textout to: ss vec " " this.name " " ) (= i 5))
}

class Outer : {
    innName: String(),
    innObj: Inner(),

    prep: (λ objs Index<String Vector<Object>>()
        (load-from-object innObj (get (snd (get objs innName)) 0))
//(textout "Outer::prep(): " (diag innObj))
        (prep innObj objs)
    ),
    work: (λ i Int() (work innObj i))
}

MainModule: {
import: "tests",
import: "Outer",
objFile: "../../res/objfile.tsd",
ss: StringStream(),
i: Int(0),
check: "[abc, cde] inn1 5",

outName: "out1",
outObj: Outer(),
objs: Index<String Vector<Object>>(),

_start: (λ 
    (with rootdir (substr @sourceFile from: 0 to: after: last: "/")
            (= objFile (+ rootdir objFile))
    )

    (rebind objs (group-by 
                (read-tsd-file objFile) 
                (λ ob Object() -> String() 
                    (get-String ob "name"))))
    (load-from-object outObj (get (snd (get objs outName)) 0))
    (prep outObj objs)
    (work outObj i)
    (textout to: outObj.innObj.ss i)
    (processRes "tsd_objects" (str outObj.innObj.ss) check)
)
}
