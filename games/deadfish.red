Red []

acc: 0
while ["q" <> cmds: ask "-->"] [
	foreach c cmds [
		do select [
			#"i" [acc: acc + 1] 
			#"d" [acc: acc - 1] 
			#"s" [acc: acc * acc] 
			#"o" [print acc]
		] c
	]
]
halt