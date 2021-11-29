/* Transd Programming Language
 * ---------------------------
 *
 * Performance benchmark 
 *
 * Matrix multiplication
 *
 * Allocate 3 matrices A, B, and C as three two-dimensional 
 * vectors of Doubles ( Vector<Vector<Double>>) and initialize
 * them with some values.
 *
 * Then perform the multiplication: C = A * B
 *
 * Algorithm:
 *
 * for i in 0..N:
 *   for j in 0..N:
 *     for k in 0..N:
 *       C[i][j] += A[i][k] * B[k][j]
 *
 */
#lang transd


MainModule: {
    dt: DateTime(),
    A: Vector<Vector<Double>>(),
    B: Vector<Vector<Double>>(),
    C: Vector<Vector<Double>>(),
    rowA: Vector<Double>(),
    rowC: Vector<Double>(),
    colC: Double(),
    n: 200,

    _start: (λ
        (resize A n) (resize B n) (resize C n)
        (for i in Range( n ) do 
            (resize (get A i) n)
            (resize (get B i) n)
            (resize (get C i) n)
            (for k in Range(n) do
                (set-el (get A i) k (to-Double k))
                (set-el (get B i) k (to-Double (- n k)))
                (set-el (get C i) k 0.0)
            ))

        (set-now dt)
        (for i in Range( n ) do 
            (rebind rowA (get A i))    // cache to increase performance
            (rebind rowC (get C i))
            (for j in Range( n ) do 
                (rebind colC (get rowC j))
                (for k in Range( n ) do 
            (+= colC (* (get rowA k) (get (get B k) j)))
        )))
        (lout "Computation time was: " (now-delta dt) " sec.")
    )
}
