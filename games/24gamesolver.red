Red []

; ---- generate all permutations of 4 given digits
permute: function [num] [
	either 1 = length? num [reduce [num]] [
		unique collect [
			foreach n num [
				d: head remove find copy num form n
				foreach p permute d [keep rejoin [n p]]
			]
		]
	]
]

; ---- generate possible expressions of 4 permuted digits
oper: "+-*/"
ops: foreach o1 oper [foreach o2 oper [foreach o3 oper [
	append [] rejoin [o1 o2 o3]
]]]
patterns: [											; operations order:
	["((" n/1 o/1 n/2 ")" o/2 n/3 ")" o/3 n/4]		; 123
	["(" n/1 o/1 "(" n/2 o/2 n/3 "))" o/3 n/4]		; 213
	[n/1 o/1 "((" n/2 o/2 n/3 ")" o/3 n/4 ")"]		; 231
	[n/1 o/1 "(" n/2 o/2 "(" n/3 o/3 n/4 "))"]		; 321
	["(" n/1 o/1 n/2 ")" o/2 "(" n/3 o/3 n/4 ")"]	; 132 <==> 312
]

random/seed now/time				
digit: charset "123456789"

; ---- game loop
while [True] [
	; get or generate 4 digits
	until [
		nums: trim/all ask "Enter 4 digits, nothing for random, or q to quit: "
		any [empty? nums nums = "q" parse nums [4 digit]]
	]
	if nums = "q" [halt]
	if empty? nums [i: copy "" print nums: sort loop 4 [append i random 9]]	

	; evaluate expressions and print result
	solutions: copy []
	foreach n permute nums [
		foreach o ops [
			foreach p patterns [
				e: copy ""
				x: rejoin p
				res: attempt [do load foreach c x [append e rejoin [c " "]]]
				if res = 24 [append solutions x]
			]
		]
	]
	print either empty? solutions ["There is no solution"] [solutions]
]