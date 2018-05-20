type exp = 
			  Add of exp*exp
			| Const of float
			| V
;;

let example = Add(Add(Const 2.14,V),Add(V,Add(V,Const 5.0)));;

(*1*)
	(* a)  a *)
	(* b)  b *)
	(* c)  b *)

(*2*) (* *)

(*3*)

(*a*)
let rec mult v e = 
	match v with
	| 1 -> e
	| _ -> Add(e,(mult (v-1) e))
;;

(*b*)

let rec belongs e1 e2 = 
	match e2 with
	| Const _ | V -> e1 = e2
	| Add(l,r) -> e1 = e2 || (belongs e1 l) || (belongs e1 r)
;;

(*c*)

let rec replace e1 e2 = 
	match e2 with
	| Const _ -> e2
	| V -> e1
	| Add(l,r) -> Add ((replace e1 l), (replace e1 r))
;;

let rec sum_list e =
	match e with
	 | Const _ -> [e]
	 | V -> [V]
	 | Add(l,r) -> (sum_list l) @ (sum_list r) 
;;

let rec right_desc_rec l = 
	match l with
	| [] -> failwith "empty expression"
	| [e] -> e
	| hd::tl -> Add(hd, (right_desc_rec tl))
;;

let right_desc e = 
	right_desc_rec (sum_list e)
;;

(*e*)
let rec sumConst e = 
	match e with 
	| V -> 0.0
	| Const x -> x 
	| Add(l,r) -> (sumConst l) +. (sumConst r)
;;

let rec sum_list_no_Const e =
	match e with
	 | Const _ -> []
	 | V -> [V]
	 | Add(l,r) -> (sum_list_no_Const l) @ (sum_list_no_Const r) 
;;

let simpl_consts e = 
	let sum = sumConst e in  
   match sum_list_no_Const e with
   	[] -> Const (sum) 
   | l -> if sum <> 0.0 then Add(Const(sum), right_desc_rec l) 
   			else right_desc_rec l 
;;                                                       