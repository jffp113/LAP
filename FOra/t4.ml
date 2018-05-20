type color = int;;
type point = float*float;;

type cshape = Line of color*point*point
			| Circle of color*point*float
			| Rect of color*point*point;;

let a = Line (34658, (2.5, 7.8), (-24.005, 1000.0001)) ;;
let b = Circle (11111, (-24.005, 1000.0003), 3.1233333) ;;

let zeroCircle c r = Circle(c,(0.0,0.0),r);;

let area cs = 
	match cs with
	| Line (_,_,_)-> 0.0
	| Circle (_,_,r) -> 3.14159 *. r *. r
	| Rect (_,(x1,y1),(x2,y2)) -> abs_float ((x1 -. x2) *. (y1 -. y2))
;;

(*Arvore em Ocaml*)
type 'a tree = Nil | Node of 'a * 'a tree * 'a tree;;

let makeLeaf v = Node(v,Nil,Nil);;

let rec size t = 
	match t with
	| Nil -> 0
	| Node(x,l,r) -> 1 + (size l) + (size r)
;;

let rec height t = 
	match t with
	| Nil -> 0
	| Node(x,l,r) -> 1 + max (height l) (height r)
;;

let rec mirror t =
	match t with
	| Nil -> Nil
	| Node(x,l,r) -> Node(x,mirror r, mirror l)
;;

(*Arvore naria*)

type 'a ntree = NNil 
				| Node of 'a * 'a ntree list;;

let makeNLeaf v = Node(v,[]);;


let rec nTreeSize t = 
	match t with
	| NNil -> 0
	| Node(v,l) -> 1 + lsize(l)
and lsize tl = 
	match tl with
	| [] -> 0
	| hd:tl -> (nTreeSize hd) + (lsize tl) 
;;