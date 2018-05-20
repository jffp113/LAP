
(* Comprimento de lista*)
let rec len l =
	match l with
		| [] -> 0 
		| hd::tl -> 1 + len tl
;;

(*Soma dos elementos de uma lista*)
let rec sum l = 
	match l with 
		| [] -> 0
		| hd::tl -> hd + sum tl
;;

(*Concatetaneção de lista*)
let rec append l1 l2 = 
	match l1 with
		| [] -> l2
		| hd::tl -> hd :: append tl l2
;;

let rec putAtEnd v l =
	match l with
		| [] -> [v]
		| hd::tl -> hd :: putAtEnd v tl
;;

(*Inversão de uma lista*)
let rec rev l = 
	match l with
		| [] -> []
		| hd::tl -> append(rev tl) [hd]
;;


let maxInt x y =
	if x > y  then x else y
;;

let rec maxList l = 
	match l with 
		| [x] -> x
		| hd::tl -> max hd (maxList tl)
;;

let rec map f l = 
	match l with 
		| [] -> []
		| hd :: tl -> (f hd) :: map f tl
;;

let rec filter b l = 
	match l with
		| [] -> []
		| hd::tl -> 
			if b hd then hd :: filter b tl
			else filter b tl 
;;

let rec flatten ll = 
	match ll with
		| [] -> []
		| hd::tl -> append hd (flatten tl)
;;

let rec flatMap f l =
	match l with
	| [] -> []
	| hd::tl -> (f hd) @ (flatMap f tl)
;;

(*let rec isOrd v l =
	match l with
	| [] -> [v]
	| hd:tl-> expr2 
		if v <= hd then v::hd::tl
		then 

let rec flatMap l = 
	match l with
		| [x] -> x
		|  hd:tl -> 
			if hd > flatMap tl then*)
let rec succAll l =
	match l with 
		| [] -> []
		| [x] -> [x + 1]
		| hd::tl -> (hd + 1) :: succAll tl
;;

