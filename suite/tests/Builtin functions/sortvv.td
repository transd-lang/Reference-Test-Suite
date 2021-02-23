/*This file is a part of Tourbillon compiler test suit.

  A test of sorting of Vector( UntypedVector() )*/

#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

/* 
AssemblyDescription : {
    entryPoint : "sortvv::_start"
}*/

sortvv: {
    import: "tests",
    v: Vector( UntypedVector() ),
    UVector uv1: [6, "a", 3, "b"],
    UVector uv2: [1, "c", 5, "d"],
    UVector uv3: [3, "h", 7, "y"],
    UVector uv4: [2, "e", 4, "t"],
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
        (textout to ss (sort v asc 
            (lambda l UntypedVector() r UntypedVector() -> Bool()
                (ret (less<Int> (get l 0) (get r 0))))) "\n")
        (textout to ss (sort v desc 
            (lambda l UntypedVector() r UntypedVector() -> Bool()
                (ret (less<Int> (get l 0) (get r 0))))) "\n")
        (textout to ss (sort v asc 
            (lambda l UntypedVector() r UntypedVector() -> Bool()
                (ret (less<String> (get l 3) (get r 3))))) "\n")
        (textout to ss (sort v desc 
            (lambda l UntypedVector() r UntypedVector() -> Bool()
                (ret (less<String> (get l 3) (get r 3))))))

        (processRes "sortvv" check (str ss))
    )
}
