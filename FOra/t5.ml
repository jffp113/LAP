let rec fact x = 
	if x = 0 then 1
	else if x>0 then x * fact(x-1)
	(*else raise (Arg.Bad "fact")*)
	else failwith "fact" 
;; 