Red ["Ternary logic"]
; !!!!!!!! This file is obsolete, see bof.red instead !!!!!!!!!

		; define trits as a set of 3 Red words: 'oui, 'non and 'bof
		; ('bof is a French teenager word expressing indifference)
trits: [oui bof non]

		; set the value of each word to itself
		; so the expression " oui " will evaluate to word 'oui
foreach t trits [set t to-lit-word t]

		; utility function to test if a word is a trit
trit?: function [t] [not none? find trits t]

		; ------ (prefix) operators ------
		; unary operator
tnot: function [a][
	select [oui non oui bof bof] a
]
		; binary (prefix) operators
tand: function [a b][
	either all [a = oui b = oui][oui][
		either any [a = non b = non][non][bof]
]]
tor: function [a b][
	either any [a = oui b = oui][oui][
		either all [a = non b = non][non][bof]
]]
timp: function [a b][
	either a = oui [b][
		either a = non [oui][
			either b = oui [oui][bof]
]]]
teq: function [a b][
	either any [a = bof b = bof][bof][
		either a = b [oui][non]
]]
		; ------ parsing (infix) operators ------
; infix operators ~~~can only be defined in Red/System~~~ FALSE !
; to emulate them in Red, we used a parsing function which transforms 
; an expression rewriting in prefix form the following infix operators:
; "&" (tand), "|" (tor), "=>" (timp), "<=>" (teq)
; precedence is: parentheses, then "-" (tnot), then other operators

tparse: function [ternary] [
				; basic parsing items
	letter: complement charset "-&|<=>()"
	name: [some letter]
	binop: [#"&" | #"|" | "=>" | "<=>" | "="]
				; correspondence between infix and prefix operators
	ops: ["&" "tand" "|" "tor" "=>" "timp" "<=>" "teq" "=" "equal?"]
				; parsing rules that do not change input
	term1: [opt #"-" ["(" expr1 ")" | name]]
	expr1: [any [term1 binop] term1]
				; parsing rules that do change input
	term: [opt [#"-" keep ("tnot")] [keep "(" expr keep ")" | keep name]]
	expr: [any [copy t term1 copy o binop keep (rejoin[
		select ops o " " parse t [collect [term]]])] term]
				; parse and rewrite ternary expression
	form parse trim/all ternary [collect [expr]]
]
		; parse and then evaluate a ternary expression 
teval: function [ternary] [do tparse ternary]

		; some examples
probe init: [
a: oui
b: bof
c: non]
do init
foreach s ["-(-a)" "a&b" "a|(b&(oui|non))" "-((a|b)|b&c)" "(a&b)|c"][
	res: tparse s
	print rejoin [pad s 18 pad res 35 " " do res]
]
