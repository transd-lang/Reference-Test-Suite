/*This file is a part of Tourbillon compiler test suit.

  A test of sorting of Vector<Tuple<>>() )*/

#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    Tpl : typealias(Tuple<Int String Int String>()),
    v: Vector<Tpl>(),
    uv1 : Tpl([[6, "a", 3, "b"]]),
    uv2 : [[1, "c", 5, "d"]],
    uv3 : Tpl([[3, "h", 7, "y"]]),
    uv4 : [[2, "e", 4, "t"]],
    ss: StringStream(),
    check: 
"[[[1, c, 5, d]], [[2, e, 4, t]], [[3, h, 7, y]], [[6, a, 3, b]]]
[[[6, a, 3, b]], [[3, h, 7, y]], [[2, e, 4, t]], [[1, c, 5, d]]]
[[[6, a, 3, b]], [[1, c, 5, d]], [[2, e, 4, t]], [[3, h, 7, y]]]
[[[3, h, 7, y]], [[2, e, 4, t]], [[1, c, 5, d]], [[6, a, 3, b]]]",
    succ: false,
    
    _start: (λ 
        (append v uv1)(append v uv2)(append v uv3)(append v uv4)
        (sort v
            (lambda l Tpl() r Tpl() -> Bool()
                (ret (less (get l 0) (get r 0)))))
        (textout to: ss v "\n")
        (sort v Range(-1 0)
            (lambda l Tpl() r Tpl() -> Bool()
                (ret (less (get l 0) (get r 0)))))
        (textout to: ss v "\n")
        (sort v
            (lambda l Tpl() r Tpl() -> Bool()
                (ret (less (get l 3) (get r 3)))))
        (textout to: ss v "\n")
        (sort v Range(-1 0)
            (lambda l Tpl() r Tpl() -> Bool()
                (ret (less (get l 3) (get r 3)))))
        (textout to: ss v)

        (processRes "sortvv" (str ss) check)
    )
}
