(*1*)

(*a) D*)
(*a) C*)
(*a) D*)


(*2	
	let f x y = x :: (y x);;
	val f : 'a -> ('a -> 'a list) -> 'a list = <fun>
*)

type point = float	* float;;
type vector = point * point;;


(*3*)

let rec isValid l = 
	match l with 
	[] -> true
	| (p1,p2)::tl -> p1 <> p2 && (isValid tl)
;;


let rec isContinuity l = 
	match l with
	| [] -> true
	| [(p1,p2)] -> true
	| (p1,p2)::(q1,q2)::xs -> p2 == q2 && (isContinuity ((q1,q2)::xs))
;; 


let rec countContinuities l = 
	match l with
	| [] -> 0
	| [(p1,p2)] -> 1
	| (p1,p2)::(q1,q2)::xs -> if p2 <> q2 
								then 1 + countContinuities ((q1,q2)::xs) 
								else countContinuities ((q1,q2)::xs)
;;

(*4*)
let join x xs =
    (Char.escaped x)^xs
;;
let rec string_of_list l =
    match l with
       [] -> ""
     | x::xs -> join x (string_of_list xs)
;;

type ctree = Nil | Node of char * ctree * ctree;;

let rec treeToChar l =
	match l with
	| Nil -> []
	| Node(c,a,b) -> if a <> Nil || b <> Nil then 
						c::('('::((treeToChar a) @ [','] @ (treeToChar b)) @ [')'])
					else c::(((treeToChar a) @ (treeToChar b)))
;;

let t1 = Node('a',
			Node('b',
				Node('d',Nil,Nil),
				Node('e',Nil,Nil)
			),
			Node('c',
				Nil,
				Node('f',
					Node('g',Nil,Nil),
					Nil
				)
			)
		);;


let rec get lists l = 
	match l with 
	[] -> ([],[])
	| hd::::tl

let rec charToTree l = 
	match l with
	| [] -> Nil
	| [x] -> Node('a',Nil,Nil)
	| x::[b;c] ->

and process l = 
	match l with 
	| [] -> Nil
	| '('::xs -> 
	| 

;;