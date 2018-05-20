type gtree = Nil | Node of string * gtree * gtree ;;

let f = Node("a", Node("m" , Node("x",Nil,Nil), Node("y",Nil,Nil)),
				  Node("f" , Node("x",Nil,Nil) ,Node("y",Nil,Nil)));;

let rec fathers  t =
	match t with
	| Nil -> []
	| Node(_,Nil,Nil) -> []
	| Node(_,m,Nil) -> fathers m
	| Node(x,m,Node(y,l,r)) -> y::fathers m @ ( fathers (Node(y,l,r)))
;;

let rec childOf m p t = 
	match t with
	Nil -> []
	| Node(x,l,Nil) -> childOf m p l
	| Node(x,Nil,r) -> childOf m p r
	| Node(x ,Node(x1,l1,r1),Node(x2,l2,r2)) -> 
					if x1 = m && x2 = p then 
					x :: (childOf((Node(x1,l1,r1)) m p ) @ (childOf((Node(x2,l2,r2)) m p )
					else 
					childOf((Node(x1,l1,r1)) m p ) @ childOf((Node(x2,l2,r2)) m p 
;;;;