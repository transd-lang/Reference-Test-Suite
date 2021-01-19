/*This file is a resource for the import_module test.*/
#lang transd
Require: {searchDirs: ['.'], packages: ['module1']}


public module module2: {
    import: "module1",
    _start: (lambda (set sharedInt 7))
}
