/*This file is a part of Transd reference test suit.

  Test of using a vector as a dataset in data queries.

*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }

MainModule: {
    import: "tests",
    ss: StringStream(),
    check: 
"[[\"apple\"], [\"avocado\"]]
[\"elppa\", \"egnaro\", \"odacova\", \"hcaep\"]
23",
    v: ["apple", "orange", "avocado", "peach"],
    n: 0,
    
    _start: (λ 
    (lout to: ss (tql v :select 
                    satisfying: (λ col1 String() (starts-with col1 "a"))))

    (tql v :update set: (λ s String() (reverse s)))
    (lout to: ss v)

    (tql v reduce: ["(size col1)"] using: (λ i Int() (+= n i)))
    (textout to: ss n)

        (processRes "vector_dataset" (str ss) check)
    )
}
