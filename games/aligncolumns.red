Red ["Align columns"]

inp: {Given$a$text$file$of$many$lines,$where$fields$within$a$line$
are$delineated$by$a$single$'dollar'$character,$write$a$program
that$aligns$each$column$of$fields$by$ensuring$that$words$in$each$
column$are$separated$by$at$least$one$space.
Further,$allow$for$each$word$in$a$column$to$be$either$left$
justified,$right$justified,$or$center$justified$within$its$column.}

lines: parse inp [collect any [
	copy line to [#"^/" | end] keep (split line #"$") skip]
]
foldLeft: function [fun neut series][
	either empty? series [neut] [foldLeft :fun fun neut series/1 next series]
]
len: foldLeft func [n s][max n length? s] 0 lines
maxs: func [na sb][
	repeat n length? na [
		na/:n: max na/:n either n > length? sb [1][1 + length? sb/:n]
	] na
]
widths: foldLeft :maxs append/dup [] 0 len lines

align: function [s n d][
	do select [
		right [pad s n]
		left [pad/left s n]
		justify [pad/left pad s to-integer n + (length? s) / 2 n]
	] d
]

foreach dir ['right 'left 'justify] [
	foreach line copy/deep lines [
		forall line [prin align line/1 pick widths index? line dir]
		print ""
	] print ""
]
