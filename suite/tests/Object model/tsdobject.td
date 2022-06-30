/*This file is a part of Transd reference test suit.

  Test of TSD objects.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

class Inner: {
    vec: Vector<String>(),
    ss: StringStream(),

    prep: (λ objs Index<String Vector<Object>>()
    ),
    work: (λ z Int() (textout to: ss vec " " this.name " " ) (= z 5))
    //work: (λ i Int() (textout "i: " i ) (= i 5))
}

class Outer : {
    innName: String(),
    innObj: Inner(),

    prep: (λ objs Index<String Vector<Object>>()
//(lout innName)
//(lout "innName: " innName)
//(lout "objs: " objs)
//(lout "get: " (get (snd (get objs innName)) 0))
        (load-from-object innObj (get (get objs innName) 0))
//(lout (diag innObj))
//(textout "Outer::prep(): " (diag innObj))
        (prep innObj objs)
    ),
    work: (λ q Int()  (work innObj q))
    //work: (λ i Int() (lout "i: " i "innObj: " (diag innObj)))
}

MainModule: {
import: "tests",
import: "Outer",
objFile: "../../res/objfile.tsd",
ss: StringStream(),
i: Int(7),
check: "[\"abc\", \"cde\"] inn1 5",

outName: "out1",
outObj: Outer(),
objs: Index<String Vector<Object>>(),

_start: (λ 
    (with rootdir (substr @sourceFile from: 0 to: after: last: "/")
            (= objFile (+ rootdir objFile))
    )
    (rebind objs (group-by 
                (read-tsd-file objFile) 
                (λ ob Object() -> String() 
                    (get-String ob "name"))))
    (load-from-object outObj (get (get objs outName) 0))

//(textout (getf outObj "innName"))
    (prep outObj objs)
    (work outObj i)
    (textout to: outObj.innObj.ss i)
    (processRes "tsd_objects" (str outObj.innObj.ss) check)
)
}

/*
  create Object.proto : { tddef{ exprs: tdcs* }; tdfld* }
  create member object : { tddef{ exprs: tdcs* }; tdfld* }
  init member object: 

Every code element along with a time point has a single corresponding
program object.
Every code element has a time point when its program object is created
and initialized.

class Outer, loadAST -
 creO proto Object.Outer

[proto.]prep: (λ ..., proto:Outer.construct
 creD FM prep1 Outer.prep() cont: proto:Outer, pout: proto:Outer
  
outObj: Outer(), MainModule.construct - 
 creO ob1 Object:Outer( proto:Outer )
  creM FM ob1.prep(proto.prep()) cont:ob1, pout:ob1

objs^(prep objs..., init{MainModule,ob1,members,prep1,pars} - 
  IndexValue.init

(load-from-object..., init{MainModule,ob1,members,prep1,pars} - 
  creM BF lfo1 (load-from-object) cont: ob1 pout: prep1
    \pars: innObj:DataRef, get:CallSite

innObj^(load-from-object innObj..., init{MainModule,ob1,members,prep1,pars,lfo1} - 
 NR innObj/ob1.innObj 

(get...^(load-from-object..., init{MainModule,ob1,members,prep1,pars,lfo1} - 
 creM BM vecget1 (get) cont: ob1 pout: lfo1

(snd...^(load-from-object (get..., init{MainModule,ob1,members,prep1,
    \pars,lfo1,pars,creM} - 
 creM BM snd1 (snd)a cont: ob1 pout: lfo1
    
(get...^(load-from-object (get (snd..., init{MainModule,ob1,members,prep1,
    \pars,lfo1,pars,creM,creM} - 
 newBM indget1 (get) cont: lfo1 pout: lfo1
    \pars: objs:DataRef, innName:String

objs^…(get (snd (get objs…, init{MainModule,ob1,members,prep1,
    \pars,lfo1,pars,creM,creM,newBM} - 
 NR objs/ob1.prep1.objs 
 NR innName/psubject 


*/
