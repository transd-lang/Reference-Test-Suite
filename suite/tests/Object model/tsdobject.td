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
    work: (λ (textout to: ss vec))
}

class Outer : {
    innName: String(),
    innObj: Inner(),

    prep: (λ objs Index<String Vector<Object>>()
        (load-from-object innObj (get (snd (get objs innName)) 0))
//(textout "Outer::prep(): " (diag innObj))
        (prep innObj objs)
    ),
    work: (λ (work innObj))
}

MainModule: {
import: "tests",
objFile: "../../res/objfile.tsd",
ss: StringStream(),
check: "[abc, cde]",

outName: "out1",
outObj: Outer(),
objs: Index<String Vector<Object>>(),

_start: (λ 
    (with rootdir (substr @sourceFile from: 0 to: after: last: "/")
            (= objFile (+ rootdir objFile))
    )

//(textout "_start(): outObj 1:" (diag outObj))
//(textout "_start(): innObj 1:" (diag outObj.innObj))

    (rebind objs (group-by 
                (read-tsd-file objFile) 
                (λ ob Object() -> String() 
                    (get-String ob "name"))))
    (load-from-object outObj (get (snd (get objs outName)) 0))
    (prep outObj objs)
    (work outObj)
    (processRes "tsd_objects" (str outObj.innObj.ss) check)
)
}
