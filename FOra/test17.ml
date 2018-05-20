
(*ex3*)
type exp = 
		Add of exp*exp
	  | Const of float
	  | V
;;

let example = Add(Add(Const 2.14,V),Add(V,Add(V,Const 5.0)));;


(*a*)
let rec mult v e = 
	match v with
	| 1 -> e
	| 2 -> Add(e,e)
	| _ -> Add(e,(mult (v-1) e))
;; 

(*b*)
let rec belongs e1 e2 = 
	match e2 with
	| V -> e1 = e2
	| Const(_) -> e1 = e2
	| Add(l,r) -> 	if e1 = e2 then true
					else if l = e2 then true
					else if r = e2 then true
					else belongs e1 l || belongs e1 r
;;

(*c*)
let rec replace e1 e2 =
	match e2 with
	| V -> e1
	| Const(_) -> e2
	| Add(l,r) -> Add((replace e1 l),(replace e1 r))
;;

