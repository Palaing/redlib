Red ["text menu"]

menu: function [items][
	print either empty? items [""] [until [
		repeat n length? items [print [n ":" items/:n]]
		attempt [pick items to-integer ask "Your choice: "]
	]]
]
menu ["fee fie" "huff and puff" "mirror mirror" "tick tock"]
