/*This file is a part of Tourbillon compiler test suit.

  A test of sorting of Vector<Tuple<>>() )*/

#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

/* 
AssemblyDescription : {
    entryPoint : "sortvv::_start"
}*/

sortvv: {
    import: "tests",
    Tpl : typealias(Tuple<Int String Int String>()),
    v: Vector<Tpl>(),
    uv1 : Tpl([[6, "a", 3, "b"]]),
    uv2 : [[1, "c", 5, "d"]],
    uv3 : Tpl([[3, "h", 7, "y"]]),
    uv4 : [[2, "e", 4, "t"]],
    ss: StringStream(),
    check: 
"[UT[1, c, 5, d], UT[2, e, 4, t], UT[3, h, 7, y], UT[6, a, 3, b]]
[UT[6, a, 3, b], UT[3, h, 7, y], UT[2, e, 4, t], UT[1, c, 5, d]]
[UT[6, a, 3, b], UT[1, c, 5, d], UT[2, e, 4, t], UT[3, h, 7, y]]
[UT[3, h, 7, y], UT[2, e, 4, t], UT[1, c, 5, d], UT[6, a, 3, b]]",
    succ: false,
    
    _start: (λ 
        (if verbose (textout " Testing 'sortvv'..." ))

        (add v uv1)(add v uv2)(add v uv3)(add v uv4)
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

        (processRes "sortvv" check (str ss))
    )
}
