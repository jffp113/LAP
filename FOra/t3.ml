let rec fact n = 
	match n with 
	| 0 -> 1 
	| _ -> n * fact (n-1)
;;

let rec len l = 
	match l with
	| []  -> 0
	| hd::tl -> 1 + len tl
;;

let (+!) (x1,y1) (x2,y2) = 
	(x1+x2, y1+y2)
;;


let rec pcount l =
	match l with
	| [] -> (0,0)
	| [0.0] -> (0,1)
	| hd::tl -> let (x,y) = pcount tl in 
				if hd <> 0.0 then 
					(1,0) +! (x,y)
				else if (y<>0 && x = 0) then 
					(0,1) +! (x,y)
				else (x,y)
;;
	