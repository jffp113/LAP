
let rec f l a = 
	match l with 
	 [] -> 0 
	 | x::xs -> (x a) + f xs a 
;;


type ctree = Class of string | Selection of string * ctree * ctree;;
let furniture = Class "mesa";;

let flying = 
	Selection("tem penas?",
		Selection("vive perto da água?",
			Selection("vive perto do mar?",
				Class("gaivota"),
				Class("pato")
			),
			Class("galinha")
		),
		Selection("tem carapaça?",
			Class("besouro"),
			Selection("tem asas coloridas?",
				Class("borboleta"),
				Selection("tem corpo listrado?",
					Class("abelha"),
					Selection("vive perto da água?",
						Class("libelinha"),
						Class("gafanhoto")
					)
				)
			)

		)
	);;

let rec allClasses t = 
	match t with
	| Class t  -> [t]
	| Selection(p,y,n) -> (allClasses y) @ (allClasses n)
;;

let rec belongs ca t = 
	match t with
	| Class c -> c = ca
	| Selection(p,y,n) -> belongs ca y || belongs ca n
;;

let rec check ca pa t = 
	match t with
	| Class c -> false
	| Selection(p,y,n) -> if p = pa then belongs ca y 
							else check ca pa y || 
							check ca pa n
;;

let rec allYes pa t = 
	match t with
	| Class p  -> []
	| Selection(p,y,n) -> if p = pa then allClasses y
									else allYes pa y @ allYes pa n
;; 