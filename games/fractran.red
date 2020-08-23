Red ["Fractran"]

inp: ask "please enter list of fractions, or input file name: "
if exists? inpf: to-file inp [inp: read inpf]

digit: charset "0123456789"
frac: [copy p [some digit] #"/" copy q [some digit] 
		keep (as-pair to-integer p to-integer q)]
code: parse inp [collect [frac some [[some " "] frac]]]

n: to-integer ask "please enter starting number n: "
x: to-integer ask "please enter the number of terms, hit return for no limit: "
l: length? code
loop x [
	forall code [
		c: code/1
		if n % c/y = 0 [
			print n: n / c/y * c/x 
			code: head code 
			break
		]
		if l = index? code [halt]
	]
]
; -------------- to test, type or paste the following input:
; 17/91 78/85 19/51 23/38 29/33 77/29 95/23 77/19 1/17 11/13 13/11 15/14 15/2 55/1
; 2
; 15