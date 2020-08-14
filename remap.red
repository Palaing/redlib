Red [
	Title:		"various iteration functions traversing one or two series"
	Author:		"Alain Goyé"
	Tabs:		4
	Credits:	https://stackoverflow.com/questions/46753092/creating-map-function-in-red-language
]

remap: function [ "applies a function to each block item, returns block of results"
	blk [block!]			"block of input values"
	fun [function! action!]	"function to apply to each input values"
	/only					"if fun outputs are blocks, do not merge them"
][
	collect [
		foreach i blk [
			either only [keep/only fun i] [keep fun i]
		]
	]
]

foldLeft: function [ "starting from neutral, successively applies binary function to last result and next series item, traversing series from left to right"
	fun [function! action!]	"function to apply to each successive couple of values"
	neutral 				"inital 1st argument of fun"
	series [series!]		"series of successive right arguments provided to fun"
] [
	either empty? series [neutral] [foldLeft :fun fun neutral series/1 next series]
]

foldRight: function [ "successively applies binary function to preceding series item and last result, starting from neutral, and traversing series from right to left"
	fun [function! action!]	"function to apply to each successive couple of values"
	neutral 				"inital 2nd argument of fun"
	series [series!]		"series of successive right arguments provided to fun"
] [
	either empty? series [neutral] [foldRight :fun next series fun series/1 neutral]
]

zip: function [ "intertwines two series, truncating the longest one"
	series1 [series!] 		"first series"
	series2 [series!]		"second series"
	/only					"yield block with each couple of results in a subblock"
] [
	res: copy either only [[]] [tail series1] 
	repeat i min length? series1 length? series2 [
		either only [
			repend/only res [series1/:i series2/:i]] [
			repend res [series1/:i series2/:i]]
	]
]

filter: function [ "extracts sub-series with series items which match a condition"
	 series	[series! bitset! typeset! any-object! map! none!]	"input series"
	 cond	[any-function!]	"condition to be matched"
	 /only					"if items are blocks, do not merge them"
	 /first					"yield the first series item matching condition"
] [
	res: collect [
		foreach item series [ 
			if cond item [
				either only [keep/only item] [keep item]
				if first [break]
			]
		]
	]
	either first [res/1] [res]
]

; forskip is ~pasted from Rebol2 source code:
forskip: func [ "Evaluates a block for periodic values in a series."
    [throw catch]
    'word [word!] "Word set to each position in series and changed as a result"
    skip-num [integer!] "Number of values to skip each time"
    body [block!] "Block to evaluate each time"
    /local orig result
][
    if not positive? skip-num [
		throw make error! rejoin ["invalid skip-num argument in forskip: " skip-num]]
    if not series? get word [
		throw make error! {forskip expected word argument to refer to a series}]
    orig: get word
    while [any [not tail? get word (set word orig false)]] [
        set/any 'result do body
        set word skip get word skip-num
        get/any 'result
    ]
]
; Examples:

; probe filter [1 2 3 4 5 6 7] func [x] [x % 2 = 0]
; probe filter/first [1 2 3 4 5  6 ] func [x] [x % 2 = 0]
; probe zip [1 2] [3 4] 
; probe zip/only [1 2] [3 4]
; probe zip "ç ol apue" "aruem ol?"
; probe remap [[1 2][3 4]] :second
; g: func [b] [copy/part b 1]
; probe remap [[1 2][3 4]] :g
; probe remap/only [[1 2][3 4]] :g
; s: function [a b] [a + b]
; foldLeft :s 0 [1 2 3 4]

; Old version of remap (may change original block):

; remap: func [				"applies a function to each block item, returns block of results"
	; bloc [block!]			"block of input values"
	; f [function! action!]	"function to apply to each input values"
	; /only					"appends block types as single values"
	; /local res
; ] [
	; res: make block! length? bloc
	; foreach item bloc [either only [append/only res f item] [append res f item] ]
	; res
; ]