/*This file is a part of Transd reference test suit.

  Test of data importing.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

TypeAlias : {
    ObjIndex: Index<String Vector<Object>>()
}

class Point : {
    x: Double(),
    y: Double(),
    @init: (λ v Vector<Double>() (= x (get v 0)) (= y (get v 1))),
    print: (λ ss StringStream() (textout to: ss "(" x "; " y ")" ))
}

class Square : {
    points: Vector<Point>(),
    draw: (λ ss StringStream() (textout to: ss "(Square::draw): ") 
            (for pt in points do (print pt ss) (textout to: ss " " )))
}

MainModule: {
import: "tests",
import: "Square",
objFile: "../../res/data_import.tsd",
ss: StringStream(),
check: "(Square::draw): (1; 2) (3; 4) ",

squareName: "square1",
squareObj: Square(),
objs: Index<String Vector<Object>>(),

_start: (λ 
    (with rootdir (substr @sourceFile from: 0 to: after: last: "/")
            (= objFile (+ rootdir objFile))
    )
    (rebind objs (group-by 
                (read-tsd-file objFile) 
                (λ ob Object() -> String() 
                    (get-String ob "name"))))
    (load-from-object squareObj (get (get objs squareName) 0))

    (draw squareObj ss)

    (processRes "data_import" (str ss) check)
)
}
