/* This file is a part of Transd reference test suite.
 
   The module 'tests' contains shared variables used by modules of the suite.
 */

#lang transd


public module tests : {
    verbose : true,
    oktests: 0,
    failtests: 0,
    
    processRes: (λ const testName String() const res String() 
                    const check String()
        (if (eq check res) 
            (+= oktests 1)
            (textout (if verbose " OK\n" else "."))
        else 
            (+= failtests 1)
            (textout "\n" testName " FAILED: " res "\n")
        ))
}
