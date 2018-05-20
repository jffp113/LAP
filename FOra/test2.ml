let x = 0;
let y = 0;


let rec pcount l = 
	match l with
	| [] -> (0,0)
	| hd::tl -> 
		if hd <> 0.0 then
			(1,0) +! pcount tl
		else
			(0,0) +! pcount tl
;;

let (+!) (x1,y1) (x2,y2) = 
	(x1 + x2, y1 + y2)
;;
