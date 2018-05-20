print_string "Hello World!\n";;

let rec mdc m n =
	 if n = 0  
	 	then m
	 else 
	 	mdc n (m mod n)
;;