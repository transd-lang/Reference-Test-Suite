/*
 * Rosetta task: Globally replace text in files
 * http://rosettacode.org/wiki/Globally_replace_text_in_several_files#Transd
 */
#lang transd

MainModule: {
    _start: (λ 
        (with files ["a.txt" "b.txt" "c.txt"] fs FileStream()
            (for f in files do
                (open-r fs f)
                (with s (replace (read-text fs) 
                        "Goodbye London!" "Hello New York!")
                    (close fs)
                    (open-w fs f)
                    (write fs (to-bytes s) (size s)))))
    )
}
