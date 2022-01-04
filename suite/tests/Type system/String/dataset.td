/*This file is a part of Tourbillon compiler test suit.

  Test of using a string as a dataset in data queries.

  'reduce' with String works with Char values, not with one-symbol
  strings.

*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: 
"202
420
",
    v: [1234, 90765432],
    
    _start: (lambda 
    (tsd v reduce: ["(to-String col1)"] using: (λ s String() 
            (with n 0 (tsd s reduce: ["(to-Int col1)"] using: 
            (λ i Int() (+= n i))) (lout to: ss n)))
    )

        (processRes "string_dataset" (str ss) check)
    )
}
