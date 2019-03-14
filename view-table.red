Red [
	Title:		"rudimentary table viewer and editor for csv-like data"
	Author:		"Alain Goyé"
	Tabs:		4
]

view-table: func [	 	"displays a block of (lines == blocks of items) in table format"
	blk [block!] 		"block of input"
	/local mainsize specs ok
] [						
	mainsize: 600x400
	specs: []
	ok: false

	tablelay: layout compose [origin 5x5 space 5x5 
		sizx: slider (as-pair mainsize/x 20) 20% [build_p]
		return
		panel gray mainsize [origin 0x0 
			p: panel silver []
		]
		sl_y: slider (as-pair 20 mainsize/y) 100% [
			p/offset/y: to-integer ((1 - face/data) * min 0.0 mainsize/y - p/size/y)
		]
		return
		sl_x: slider (as-pair mainsize/x 20) 0% [
			p/offset/x: to-integer (face/data * min 0.0 mainsize/x - p/size/x)
		]
		return
		pad 400x0
		button "ok" [ok: true unview]
		button "cancel" [unview]
	]

	build_specs: does [	; builds specs for layout of table
		specs: copy [origin 1x1 space 0x0 ]
		foreach line blk [
			foreach item line [
				append specs compose [field snow t_size (item)]
			]
			append specs 'return
		]
	]	
	build_specs

	build_p: does [
		t_size: as-pair 600 * sizx/data 20 
		p_lay: layout specs 
		p/pane: p_lay/pane
		p/size: p_lay/size
	]
	build_p

	view tablelay
	ok
]
; do %parse-csv.red
; test: {;"";;^/"nom2";prénom2;"email2"^/"nom3";prénom3;"email3^/and something else"}
; print either view-table truc: parse-csv test [build-csv truc] [test]
