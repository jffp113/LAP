(*Ex 14*)
let rec succAll l =
	match l with 
		| [] -> []
		| [x] -> [x + 1]
		| hd::tl -> (hd + 1) :: succAll tl
;;

(*15*)

let rec belongs v l = 
	match l with 
		| [] -> false
		| hd::tl -> if v = hd then true 
					else belongs v tl
;; 

let rec union l1 l2 = 
	match l1 with 
		| [] -> l2
		| hd::tl -> if belongs hd l2 then union tl l2
					else hd :: union tl l2
;;

let rec inter l1 l2 = 
	match l1 with 
		| [] -> []
		| hd::tl -> if belongs hd l2 then hd :: inter tl l2
					else inter tl l2
;;

let rec diff l1 l2 = 
	match l1 with 
		| [] -> []
		| hd::tl -> if belongs hd l2 then diffRec tl l2 
					else hd :: diffRec tl l2
;;

let noCommuns l1 l2 =
	let ld1 = diff l1 l2 in
		let ld2 = diff l2 l1 in
			union ld1 ld2
;;


let rec power l = 
	match l with
	| [] -> [[]]
	| hd::tl -> 
	let a = power tl in
	let b = [hd] @ power tl in
	let c = a :: [] in 
	 b :: c
;;


(*ex 16*)

let rec nat x =
	if x = 0 then []
	else (x - 1) :: nat (x - 1)
;;