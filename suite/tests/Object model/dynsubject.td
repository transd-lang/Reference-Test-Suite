/***
 This file is part of the reference test suit of Transd programming language.
 File:          dynsubject.td
 Created:       Mon, 01 Aug 2022 15:53
 Last edited:   Mon, 01 Aug 2022 17:22

 Abstract: The term 'dynamic subject' refers to the situation when
 a callsite of a class' method is executed several times (e.g. in a loop) and
 the subject of the call refers to different objects at different executions.
 E.g. if 'vec' is a vector containing objects of some class having a method
 called 'meth', then 'obj' in the 'meth' call is the dynamic subject:

 (for obj in vec do
     (meth obj))

 This test checks that dynamic subjects in various types of method calls
 work correctly.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }


class ClA: {
    mem1: Int(),

    @init: (λ i Int() (set mem1 (/ i 2))),

    @to-String: (λ ss StringStream() 
                    (textout to: ss "ClA:{ mem1: " mem1 " }")),

    meth1: (λ x Int() 
        (ret (+ x mem1))
    ),
    
    la1: Lambda<Int Int>(λ x Int()
        (ret (+ x mem1))),

    meth2: (λ i Int()
        (if (< i mem1) (ret 1))
        (ret (+ i (exec la2 (- i 1))))
    ),

    la2: Lambda<Int Int>(λ x Int()
        (ret (meth2 (- x mem1)))
    )
}


MainModule: {
    import: "tests",
    v: Vector<ClA>(), // container for objects
    ss: StringStream(),
    check: 
"8 10 12 14 
8 10 12 14 
8 10 12 14 
71 43 29 17 ",

    _start: (λ  
        // filling the container with several objects
        (for i in Seq( 6 20 4 ) do
            (append v ClA( (to-Int i)))
            // call with dynamic subject
            (textout to: ss (meth1 (back v) 5) " ")
        )
        (lout to: ss "")

        // calling a method with a dynamic subject
        (for ob in v do
            (textout to: ss (meth1 ob 5) " "))
        (lout to: ss "")

        // calling a lambda with a dynamic subject
        (for ob in v do
            (textout to: ss (exec ob.la1 5) " "))
        (lout to: ss "")

        // recursive call with a dynamic subject
        (for ob in v do
            (textout to: ss (exec ob.la2 25) " "))
        (processRes "dynsubject" (str ss) check)
    )
}

