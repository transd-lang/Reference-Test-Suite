/*This file is a part of Transd reference test suit.

  Interfaces.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

interface IFace1: {
	IMeth1: (λ)
}

public module Shared: {
    ss: StringStream()
}

class ClassA : {
    import: "Shared",
    @impl: IFace1,
    IMeth1: (λ (textout to: ss "(ClassA::IMeth1)"))
}

MainModule : 
{
	import: "ClassA",
    import: "Shared",
    import: "tests",
    check: "(MainModule::func1):
(ClassA::IMeth1)",
	objA: ClassA(),
	
    func1: (λ par IFace1() (lout to: ss "(MainModule::func1):") (IMeth1 par)),

	_start: (λ 
        (func1 objA)

        (processRes "interface" (str ss) check)
    )
}

