Red [
	Title:		"convert csv file to and from Red nested blocks format"
	Author:		"Alain Goyé"
	Tabs:		4
]

parse-csv: func [		"parses csv string into a block of (lines == blocks of items)"
	str [string!] 		"input string"
	/del sep			"delimiter - default is ';'"
] [	
	noquote: complement charset {"}
	sep: any [sep ";"]
	nosep: complement charset reduce [sep lf]
	item: [
		[{"} copy s any [noquote | {""}] {"} to [sep | lf | end]
		] (replace/all s {""} {"}) |
		[copy s any nosep to [sep | lf | end]]
	]
	line: copy []
	parse str [	collect any [ 
		item (append line s) [
			sep |
			[lf | end] keep (line) (line: copy [])
		]				
	]]
]

build-csv: func [		"builds csv from a block of (lines == blocks of items)"
	blk [block!] 		"block of input"
	/del sep			"delimiter - default is ';'"
	/only				"if flag 'only' is set, return a block of lf-terminated csv lines"
] [	
	sep: any [sep ";"]
	res: copy either only [[]] [""]
	foreach line blk [
		csvline: copy ""
		foreach item line [
			repend csvline either any [find item {"} find item {^/} find item sep ] [
				[{"} replace/all copy item {"} {""} {"} sep]
			] [
				[item sep]
			]
		]
		change back tail csvline "^/"
		append res csvline
	]
	res
]

; test: {o;"";;^/"nom2";prénom2;"""this"" and that"^/"nom3";prénom3;"email3;^/and ""something"" else"}
; probe res: parse-csv test
; probe build-csv res 
