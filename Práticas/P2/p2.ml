(*Ex 14*)
let rec succAll l = 
	match l with
	| [] -> []
	| hd::tl -> (hd + 1) :: succAll tl;;


(*Ex 15*)
let rec belongs v l =
	match l with
	 | [] -> false
	 | hd::tl -> if hd = v then true
	 			 else belongs v tl
;; 

let rec belongs v l =
	match l with
	 | [] -> false
	 | hd::tl -> hd = v || belongs v tl
;; 

let rec union l1 l2 = 
	match l1 with
	| [] -> l2
	| hd::tl -> if belongs hd l2 then union tl l2
			else hd :: (union tl l2)
;;

let rec diff l1 l2 = 
	match l1 with
	| [] -> []
	| hd::tl -> if belongs hd l2 then diff tl l2
			    else hd :: diff tl l2
;;

let rec insert v ll = 
	match ll with
	| [] -> []
	| hd::tl -> (v::hd) :: insert v tl
;;

let rec power l = 
	match l with
	| [] -> [[]]
	| hd::tl ->  let a = power tl in
		insert hd a @ a
;;
(*16*)

let rec nat n = 
	 match n with
	 | 0 ->  []
	 | _ -> (n-1) :: nat (n-1)
;;

(*17*)
let rec pack l = 
	match l with
	| [] -> []
	| hd::tl -> let a = pack tl in
				match a with
				| [] -> [(hd,1)]
				| (x,y)::tl2 -> 
						if hd = x then
							(x,y+1)::tl2
						else
							(hd,1)::a
;;	


let rec unpack l = 
	match l with
	| [] -> []
	| (x,y)::tl -> if y = 0 then unpack tl
					else x :: (unpack ((x,y-1) :: tl))
;;

(*18*)
