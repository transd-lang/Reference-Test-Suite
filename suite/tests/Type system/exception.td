/***
 File:          exception.td
 Created:       Tue, 28 Jun 2022 23:28
 Last edited:   Tue, 28 Jun 2022 23:39
 Abstract: Testing Exception type.
*/
#lang transd

Require : { searchDirs: ["../.."], packages: ["tests"] }


MainModule: {
import: "tests",
ss: StringStream(),
check: "OK. Done.",

// '(throw)' form throws an exception. It receives an optional exception
// type and message text.
func: (λ (throw :stopIter "message" )),

_start: (λ
    // The thrown exception can be catched with '(catch)' form. The
    // exception object is accessible via '@ex' built-in variable.
    (try (func) 
    (catch (if (is-type @ex :stopIter) (textout to: ss "OK. ")
            else (textout to: ss "Type mismatch. "))))
    (textout to: ss "Done.")
    (processRes "exception" (str ss) check)
)
}
