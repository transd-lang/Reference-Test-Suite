/*This file is a part of Transd reference test suit.

  Test of data importing.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

TypeAlias : {
    ObjIndex: typealias(Index<String Vector<Object>>())
}

class Point : {
    x: Double(),
    y: Double(),
    @init: (λ v Vector<Double>() (= x (get v 0)) (= y (get v 1))),
    print: (λ ss StringStream() (textout to: ss "(" x "; " y ")" ))
}

class Color : {
    r: Int(),
    g: Int(),
    b: Int(),
    @init: (λ v Vector<Int>() (= r (get v 0)) (= g (get v 1))
                (= b (get v 2))),
    print: (λ ss StringStream() (textout to: ss "(" r "; " g "; " b ")" ))
}

class Circle : {
    center: Point(),
    color: Color(),
    create: (λ objs ObjIndex()),
    draw: (λ ss StringStream() (textout to: ss "(Circle::draw): \n Center: ") 
            (print center ss) (textout to: ss ", Color: ") 
            (print color ss))
}

class Diagram : {
    shape: String(),
    shapeObj: Circle(),
    create: (λ objs ObjIndex()
//(lout "objs: " objs)
        (load-from-object shapeObj (get (get objs shape) 0))
        (create shapeObj objs)),
    draw: (λ ss StringStream() (draw shapeObj ss))
}

MainModule: {
import: "tests",
import: "Diagram",
objFile: "../../res/data_import1.tsd",
ss: StringStream(),
check: "(Circle::draw): 
 Center: (1; 2), Color: (3; 4; 5)",

diagName: "diag1",
diagObj: Diagram(),
objs: Index<String Vector<Object>>(),


_start: (λ 
    (with rootdir (substr @sourceFile from: 0 to: after: last: "/")
            (= objFile (+ rootdir objFile))
    )
    (rebind objs (group-by 
                (read-tsd-file objFile) 
                (λ ob Object() -> String() 
                    (get-String ob "name"))))
    (load-from-object diagObj (get (get objs diagName) 0))
//(lout "objs: " objs)
    (create diagObj objs)
    (draw diagObj ss)

    (processRes "data_import1" (str ss) check)
)
}
