Red []

random/seed now/time				; initialize a random generator
digit: charset "123456789"			; any character between 1 and 9
mu: charset "*/"					; product (or quotient)
ad: charset "+-"					; sum (or difference)
fact: ["(" expr ")" | digit]		; factor: parenthesised expression or digit
term: [								; term: product of factors or unique factor
	"(" fact some [mu fact] ")"	|	; either product is enclosed in parentheses
	change copy e [fact some [mu fact]] (rejoin ["(" e ")"]) | ; or we add them
	fact							; for correct evaluation by Red interpreter
]
expr: [term any [ad term]]			; expression: term or sum of terms

while [True] [ 
nums: copy ""						; pick and display 4 digits
print rejoin ["Input digits are: " nums: sort loop 4 [append nums random 9]]
print rejoin [
	"Expression is " 				; assert if given input is valid expression
	either "q" = trim i: ask "Enter expression, or 'q' to quit: " [halt] [""]
	either eok: parse i expr ["valid"] ["NOT valid"]
	"^/Digits used are "			; assert if all, and only given digits used 
	either nok: nums = sort rejoin parse i [collect some [keep digit | skip]] [
		""] ["NOT "] "exactly those given"
	"^/Expression evaluates to: "	; evaluate expression, assert if result= 24 
	res: either eok [do load foreach c i [append "" rejoin [c " "]]] [0]
	either all [eok nok res = 24] ["^/You win!^/"] ["^/You loose!^/"]
]]