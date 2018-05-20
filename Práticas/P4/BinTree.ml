(*Tree Mod*)


type tree = Nil | Node of int * tree * tree ;;

let rec make l = 
	match l with
	| [] -> Nil
	| hd::tl -> Node(hd,Nil,(make tl))
;;


let rec maxRec t = 
	match t with
	| Nil -> min_int
	| Node(x,l,r) -> Pervasives.max x (Pervasives.max (maxRec l) (maxRec r) )
;;

(*
let max t =
	match t with
	| Nil -> failwith "Tree is Null"
	| Node(x,Nil,Nil) -> x
	| Node(x,Nil,r) -> Pervasives.max x (max r)
	| Node(x,l,Nil) -> Pervasives.max x (max l)
	| Node(x,l,r) -> Pervasives.max x (Pervasives.max (max l) (max r))
;; 
*)


let max t = 
	match t with
	| Nil -> failwith "Tree is Null"
	| _ -> maxRec t
;;


let rec loadE i = 
	try
		let s = input_line i in
			match s with
			 | "-" -> Nil
			 | _ ->  
		let l = loadE i in
		let r = loadE i in
		Node(int_of_string s,l ,r)
	with 
		| End_of_file -> failwith "loadE: premature End_of_file"
;;

let load ic = 
	let input = open_in ic in
		let t = loadE input in
		close_in input; t 
;;

let rec storeE o t = 
	match t with
	| Nil -> output_string o "-\n"; 
	| Node(x,l,r) -> output_string o (string_of_int x);
					 output_string o "\n";
					 (storeE o l);(storeE o r)
;;

let store oc t = 
	let output = open_out oc in 
		storeE output t; close_out output
;;
