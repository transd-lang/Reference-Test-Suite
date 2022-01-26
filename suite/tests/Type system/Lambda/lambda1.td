/*This file is a part of Tourbillon compiler test suit.

  Test of Lambda type:

  - a class StepFunc has a lambda as 'func' data member;
  - @init method initializes 'func' with the passed argument;
  - 'call' method executes 'func' with the passed argument.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }



class StepFunc : {
    func: Lambda<Int Int>(),
    @init: (λ f Lambda<Int Int>() (rebind func f )),
    call: (λ i Int() (ret (exec func i)))
}

MainModule: {
import: "tests",
ss: StringStream(),
check: "do op: 7",

     op: Lambda<Int Int>(λ i Int() (textout to: ss "do op: ") (ret (+ i 5))),

	_start: (λ 
        (with sf StepFunc( op )
            (textout to: ss (call sf 2))
        )


    (processRes "lambda1" (str ss) check)
)
}
