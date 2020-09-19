Red ["Multifactorial"]

multifact: function [n d][
	res: m: n
	while [0 < m: m - d][res: res * m]
	res
]
repeat d 5 [
	prin ["Degree" d ":"]
	repeat n 10 [prin ["" multifact n d]]
	print ""
]