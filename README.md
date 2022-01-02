# Tourbillon compiler test suite

A set of tests for checking the correctness of implementation of Transd programming language in Tourbillon compiler.

These tests can be run with the Transd interpreter called TREE3 (short for "Transd Expression Evaluator") or with any program that has the Tourbillon compiler embedded.

### How to run these tests

1. Download this test suite.

2. Download or compile the Transd REPL program called [TREE3](https://github.com/transd-lang/TREE3)

3. Go to the directory with the "tree3" binary. 
   On the command line type (replacing "<PATH>" with the actual full path to the directory with the downloaded test suite):
  
   `./tree3 "<PATH>/runtests.td"`

In case the tests are successful, the output will look like this:

```
$ ./tree3 "/home/transd/Tourbillon-test-suite/suite/runtests.td"

Tests started: 
 Testing eval.td........................................... OK
 Testing fibo.td........................................... OK
 Testing files.td.......................................... OK
 Testing imp.td............................................ OK

  // -- More output... --//

 Testing Type system/String/string.td...................... OK
 Testing Type system/Vector/create.td...................... OK
 Testing Type system/Vector/matrices.td.................... OK
 Testing Type system/Vector/meths.td....................... OK
Successful tests: 55
Failed tests: 0
