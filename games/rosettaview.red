Red [
	Title:   "Rosetta code - Red programs viewer and tester"
	Author:  "Alain Goyé"
	File: 	 %rosettaview.red
	Tabs:	 4
	License: "MIT / X11 license"
	Notes:	 {} 
]

redpage: read http://rosettacode.org/wiki/Category:Red
redlist: parse redpage [
	collect [
		thru <div lang="en" dir="ltr" class="mw-content-ltr">
		some [	
			thru {<li><a href="} keep to {" title="} 
			thru {">} keep to </a>
		]
	]
]
links: extract redlist 2
names: extract next redlist 2
link: does [rejoin [http://rosettacode.org pick links t/selected "#Red"]]

tag: [#"<" thru #">"]
numentity: ["&#" copy ecode to #";" skip]
rule: [collect [any [
		"<br />" keep (#"^/")						|
		tag 										| 
		"&quot;" keep (#"^"")						|	;"
		"&lt;" 	keep (#"<")							|
		"&gt;" keep (#">")							|
		"&#160;" keep (#" ")						|
		copy e numentity keep (to-char to-integer ecode)		| 
		keep copy _ to [tag | #"&" | numentity | end]]]]
		
getcode: does [
	if tload/visible? [return code]
	parse read link [
		thru {"Category:Red"} thru "<pre " thru ">"
		copy html to </pre> to end]
	code: rejoin parse html rule
	tload/visible?: true
	code
]

view/no-wait [
	t: text-list 200x200 data names [tload/visible?: false] below 
	button "run" [do getcode] 
	button "code" [print getcode]
	button "browse" [browse link]
	tload: text bold snow leaf "loaded" hidden
	do [t/selected: 1]
]

