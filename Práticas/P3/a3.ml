(*ex 21*)
type 'a tree = Nil | Node of 'a * 'a tree * 'a tree;;

let rec howMany v t = 
	match t with 
		|Nil -> 0
		|Node(x,l,r) -> if v = x then 
							1 + (howMany v l) + (howMany v r)
						else
							(howMany v l) + (howMany v r)
;;  


let ex1 = Node(1,Node(2,Node(1,Nil,Nil),Node(2,Nil,Nil)),Node(1,Node(1,Nil,Nil),Nil));;
howMany 1 ex1 = 4;;

let rec eqPairs t = 
	match t with
	| Nil -> 0
	| Node((x,y),l,r) -> (if x = y then 1 else 0) + eqPairs l + eqPairs r
;;

let ex2 = Node((1,1),Node((1,2),Node((5,21),Nil,Nil),Node((3,3),Nil,Nil)),Node((2,2),Nil,Nil));;


let rec treeToList t = 
	match t with
		| Nil -> []
		| Node(x,l,r) -> x :: ((treeToList l) @ (treeToList r))
;;

(*22*)

let rec height t = 
	match t with 
		| Nil -> 0
		| Node(x,l,r) -> 1 + max (height l) (height r)
;;

let rec balanced t = 
	match t with
	| Nil -> true
	| Node(v,l,r) -> let hl = height l in
					let hr = height r in
					if abs (hl - hr) > 1 then false
					else balanced l || balanced r
;;

(*23*)
let rec isThere v l = 
	match l with
	| [] -> false
	| hd::tl -> if hd = v then true
				else isThere v tl
;;

let rec union l1 l2 = 
	match l1 with
	| [] -> l2
	| hd::tl -> if isThere hd l2 then 
					union tl l2
				else
					hd :: (union tl l2)
;;

let rec subtrees t = 
	match t with 
	| Nil-> [Nil]
	| Node(x,l,r) -> let rl = subtrees r in
						let ll = subtrees l in 
							t :: (union ll rl)
;;

(*24*)

let rec spring v t =
	match t with
	 | Nil -> Node(v,Nil,Nil)
	 | Node(x,l,r) -> Node(x,(spring v l),(spring v r)) 
;;

(*25*)

let rec fall t = 
	match t with
	| Nil -> Nil
	| Node(_,Nil,Nil) -> Nil
	| Node(x,l,r) -> Node(x,(fall l),(fall r))
;;


(*26*)
	type 'a ntree = NNil | NNode of 'a * 'a ntree list

	let rec ntreeToList nt = 
		match nt with
			| NNil -> []
			| NNode(x,lt) -> x :: listNTree lt

	and listNTree l =
			match l with
			| [] -> []
			| hd::tl -> (ntreeToList hd) @ (listNTree tl)
;;

let rec nsubtrees nt = 
	match nt with
	| NNil -> []
	| NNode(x,nl)-> nt :: (nsubList nl)
and nsubList lt =
	match lt with
	| [] -> []
	| hd::tl -> union (nsubtrees hd) (nsubList tl)  
;;


let rec nspring v nt = 
	match nt with
	| NNil -> NNode(v,[])
	| NNode(x,[]) -> NNode(x,[NNode(v,[])])
	| NNode(x,l) -> NNode(x,(lnSpring v l))
and lnSpring v l = 
	match l with
	| [] -> []
	| hd::tl -> (nspring v hd) :: (lnSpring v l)
;;

let rec rmNil nt = 
	match nt with
	| NNil -> NNil
	| NNode(x,l) -> NNode(x,lrmNil l)
and lrmNil l = 
	match l with
	| [] -> []
	| NNil::tl -> lrmNil tl
	| hd::tl -> (rmNil hd) :: (lrmNil tl)
;;

let rec nfall nt = 
	match nt with
	| NNil -> NNil
	| NNode(_,[]) -> NNil
	| NNode(x,l) -> rmNil (NNode(x,(lnfall l)))
and lnfall lt = 
	match lt with
	| [] -> []
	| hd::tl -> (nfall hd) :: (lnfall tl) 
;;
(*27*)

type exp =
      Add of exp*exp
    | Sub of exp*exp
    | Mult of exp*exp
    | Div of exp*exp
    | Power of exp*int
    | Sim of exp
    | Const of float
    | Var
;;
