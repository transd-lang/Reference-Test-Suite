/*This file is a part of Transd reference test suit.

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
    fs: FileStream(),
    fname: "fs_readline.txt",
    s: "ABC\ndef\nghi",
    ss: StringStream(),
    check: 
"[65, 66, 67, 10, 100, 101, 102, 10, 103, 104, 105]
ABC
def
ghi
[\"ABC\", \"def\", \"ghi\"]",

	_start: (λ 
    (with dir (substr @sourceFile from: 0 to: after: last: "/")
        (open-w fs (+ dir "/" fname) "w")
        (write fs (to-bytes s) (size s))
        (close fs)
        (open-r fs (+ dir "/" fname))
        //(textout to: ss (read-lines fs) "\n")
        (with barr ByteArray()
            (read-bytes fs barr)
            (textout to: ss barr "\n")
        )
        (rewind fs)
        (with str String()
            (while (getline str fs)
                (textout to: ss str "\n"))
            (rewind fs)
            (textin from: fs str)
            (textout to: ss (split str))
        )
    )
    (processRes "fs_readline" (str ss) check)
    )
}
