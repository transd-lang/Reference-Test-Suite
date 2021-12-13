/*This file is a part of Tourbillon compiler test suit.

  File stream operations.

Test's script:

1. File 'fname' is opened for writing;
2. The string 's' is written to the file;
3. File 'fname' is closed;
4. File 'fname' is reopened for reading;
5. The 'read-lines' function reads all lines from the file in binary mode into
   a ByteArray object, and this object is printed out to 'ss' StringStream;
6. The file is rewinded (that is, its current position is set to the beginning
   of the file);
7. The file contents are read line by line in a loop with 'getline' function,
   which converts the line from bytes to the text, and printed to the
   StringStream;
8. The file is rewinded again;
9. The file contents are read into a single string, which then is split to
   lines into a Vector object, and this object is printed out to the
   StringStream.
*/
#lang transd

Require : { searchDirs: ["../../.."], packages: ["tests"] }


MainModule : {
    import: "tests",
    ss: StringStream(),
    check: 
"Fried chicken.......3.70 USD
Ice-cream...........1.50 USD
----------------------------
             Total: 5.20 USD
",

	_start: (λ 
        (with pr1 3.7 pr2 1.5
            (lout to: ss width: 20 fill: "." :left "Fried chicken" 
                     prec: 2 :fixed pr1 " USD" )
            (lout to: ss width: 20 "Ice-cream" pr2 " USD" )
            (lout to: ss width: 28 fill: "-" )
            (lout to: ss width: 20 fill: " " :right "Total: " (+ pr1 pr2) " USD" )
        )

        (processRes "ss_format" (str ss) check)
    )
}
