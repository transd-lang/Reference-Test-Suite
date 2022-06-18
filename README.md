# Transd Reference Test Suite


A set of tests for checking the correctness of working of Transd programming language. Also, this suite can be used as a comprehensive source of guiding examples for using various language elements.

These tests can be run with the Transd interpreter called TREE3 or with any program that has the Transd meta-compiler embedded.

### How to run test suite

1. Download this test suite.

2. Download or compile the Transd interpreter called [TREE3](https://github.com/transd-lang/TREE3)

3. Go to the directory with the "tree3" binary. 
   On the command line type (replacing "<PATH>" with the actual full path to the directory with the downloaded test suite):
  
   `./tree3 "<PATH>/runtests.td"`

In case the tests are successful, the output will look like this:

```
$ ./tree3 "/home/transd/Reference-Test-Suite/suite/runtests.td"

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
Successful tests: 82
Failed tests: 0
```


### Browsing test suite

The source code of the Suite is planned to contain the exhaustive set of examples of 
using every language element in every syntactic variant in which it can be used. Therefore,
this Suite can be regarded as a comprehensive syntactic and semantic practical reference for
the language. Currently, many test files contain informative comments to the code in them, 
and the work is being done to add such comments to the majority of test files.

Apart from inline comments in the code, some files contain a comment section named
"Transd code example" in the end of the file, with more extended comments and notes.

Below is a list of references to the test suite files containing tests of particular
parts of the language.

* [Test driver](https://github.com/transd-lang/Reference-Test-Suite/blob/main/suite/runtests.td) - the program that runs the tests can itself be regarded as a test and
example of Transd language features.

* [Vector](https://github.com/transd-lang/Reference-Test-Suite/tree/main/suite/tests/Type%20system/Vector)

* [String](https://github.com/transd-lang/Reference-Test-Suite/tree/main/suite/tests/Type%20system/String)

* [Lambda](https://github.com/transd-lang/Reference-Test-Suite/tree/main/suite/tests/Type%20system/Lambda)

* [Data processing](https://github.com/transd-lang/Reference-Test-Suite/tree/main/suite/tests/TSD)

* [Control flow](https://github.com/transd-lang/Reference-Test-Suite/tree/main/suite/tests/Control)
  - ['for' statement](https://github.com/transd-lang/Reference-Test-Suite/blob/main/suite/tests/Control/for.td)
  - ['if' statement](https://github.com/transd-lang/Reference-Test-Suite/blob/main/suite/tests/Control/if.td)





