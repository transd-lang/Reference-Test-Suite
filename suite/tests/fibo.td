/*This file is a part of Tourbillon compiler test suit.

  Generating the Fibonacci sequence.
  Testing Ŕange, 'for', 'with'.
*/

#lang transd

Require : { searchDirs: [".."], packages: ["tests"] }

fibo: {
    import: "tests",
	v: Vector<Int>(30),
	check: "1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 121393 196418 317811 514229 832040 ",
    succ: false,

	_start: 
	(λ 	(if verbose (textout " Testing 'fibo'..." ))

    (set-el v 0 1) (set-el v 1 1)
		(for n in Range(2 (size v)) do
				(set-el v n (+ (get v (- n 1))(get v (- n 2))))
		)
		(with ss StringStream()
			(for n in Range((size v)) do
				(textout to: ss (get v n) " ")
			)

            (processRes "fibo" check (str ss))
		)
	)
}
