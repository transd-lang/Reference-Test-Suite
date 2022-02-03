/*This file is a part of Transd reference test suit.

  Test of recursive import.

TODO:
  test: 
  pub
  priv
  sec
  allow
  deny

*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }

public module mod1 : {
    import: "MainModule",
    import: "mod2",
    b: 5,
    dodiv: (λ (ret (/ a b))),
    dodiv1: (λ (ret (/ MainModule::a b)))
}

public module MainModule : {
    import: "tests",
    import: "mod1",
    ss: StringStream(),
    check: "7 7",
    a: 35,
    _start: (λ 
        (textout to: ss (mod1::dodiv) " ")
        (textout to: ss (mod1::dodiv1))

        (processRes "rec_import" (str ss) check)
    )
}

mod2 : {
    import: "mod1",
    import: "MainModule",
    c: 5,
    dodiv: (λ (ret (/ a b))),
    dodiv1: (λ (ret (/ MainModule::a b)))
}
