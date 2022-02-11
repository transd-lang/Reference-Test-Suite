/*This file is a part of Transd reference test suit.

  Interfaces.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

interface IFace1: {
	IMeth1: (λ)
}

class ClassA : {
    import: "MainModule",
    @impl: IFace1,
    IMeth1: (λ (textout to: ss "(ClassA::IMeth1)"))
}

public module MainModule : 
{
	import: "ClassA",
    import: "tests",
    ss: StringStream(),
    check: "(MainModule::func1):
(ClassA::IMeth1)",
	objA: ClassA(),
	
    func1: (λ par IFace1() (lout to: ss "(MainModule::func1):") (IMeth1 par)),

	_start: (λ 
        (func1 objA)

        (processRes "interface" (str ss) check)
    )
}

