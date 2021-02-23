# Tourbillon compiler test suite

A set of tests for checking the correctness of implementation of Transd programming language in Tourbillon compiler.

These tests can be run with the Transd interpreter called FREND (FRont END) or with any program that has the Tourbillon compiler embedded.

### How to run these tests

1. Download this test suite.

2. Download or compile the Transd REPL program called [Frend](https://github.com/transd-lang/frend)

3. Go to the directory with the "frend" binary. 
   On the command line type (replacing "PATH" with the full path to the tests directory):
  
   `frend "<PATH>/runtests.td"`

In case tests have been successful, the output will look like this:

```
Tests started:
 Testing 'eval'... OK
 Testing 'fibo'... OK
 Testing 'files'... OK
 Testing 'imp'... OK
 Testing 'try'... OK
 Testing 'tsdbase'... OK
 Testing 'with'... OK
 Testing 'sort'... OK
 Testing 'sortvv'... OK
 Testing 'decl'... OK
 Testing 'uvector'... OK
 Testing 'vector'... OK
Successful tests: 12
Failed tests: 0
```
