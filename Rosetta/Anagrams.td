/* Rosetta task: Anagrams
 * http://rosettacode.org/wiki/Anagrams
 *
 * 'unixdict.txt' file can be downloaded at:
 * http://wiki.puzzlers.org/pub/wordlists/unixdict.txt
 * 
 */

#lang transd

MainModule: {
    _start: (λ 
        (with fs FileStream() words String()
            (open fs "/mnt/tmp/unixdict.txt")
            (textin fs words)
            ( -|
              (split words) 
              (group-by (λ s String() -> String() (sort (cp s))))
              (regroup-by (λ v Vector<String>() -> Int() (size v)))
              (max-element)
              (snd)
              (textout)
            )
        ))
}
