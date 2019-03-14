Red [
	Title:		"variant of foreach which collects all iteration results in a block"
	Author:		"Alain Goyé"
	Tabs:		4
]

remap: func [				"applies a function to each block item, returns block of results"
	bloc [block!]			"block of input values"
	f [function! action!]	"function to apply to each input values"
	/only					"appends block types as single values"
] [
	res: make block! length? bloc
	foreach item bloc [either only [append/only res f item] [append res f item] ]
	res
]
; probe remap [[1 2][3 4]] :second
; g: func [b] [copy/part b 1]
; probe remap [[1 2][3 4]] :g
; probe remap/only [[1 2][3 4]] :g
