(* RegExp module body *)

(* 
Aluno 1: 49771
Aluno 2: 49780

Comment:

?????????????????????????
?????????????????????????
?????????????????????????
?????????????????????????
?????????????????????????
?????????????????????????

*)

(*
01234567890123456789012345678901234567890123456789012345678901234567890123456789
   80 columns
*)


(* REGULAR EXPRESSIONS *)

type regExp =
      Str of string
    | Class of string
    | NClass of string
    | Any
    | Seq of regExp * regExp
    | Or of regExp * regExp
    | Not of regExp
    | Zero of regExp
    | ZeroOrOne of regExp
    | ZeroOrMore of regExp
    | OneOrMore of regExp
    | Repeat of int * int * regExp
;;


(* STRINGS *)

let cut s =
    (String.get s 0, String.sub s 1 ((String.length s)-1))
;;

let join x xs =
    (Char.escaped x)^xs
;;

let rec list_of_string s =
    if s = "" then []
    else
        let (x,xs) = cut s in
            x::list_of_string xs
;;

let rec string_of_list l =
    match l with
       [] -> ""
     | x::xs -> join x (string_of_list xs)
;;

let rec searchStringMatch f s = 
    match s with 
     [] ->  (false,[],[])
     |x::xs -> 
        match f with 
         [] -> (false,[],[])
        |hd::tl -> if hd = x then (true,[x],xs) 
                     else searchStringMatch tl s
;;

let rec searchStringNotMatch f s = 
    match s with 
     [] ->  (false,[],[])
     |x::xs -> 
        match f with 
         [] -> (true,[x],xs)
        |hd::tl -> if hd <> x then searchStringNotMatch tl s
                     else (false,[],[])
;;

(* matchAtStart *)

let rec matchAtStartRE line re =
    match re with
      | Zero p -> (true, [], line)
      | Str p -> (match line with
                 | [] -> (false,[],[])
                 | hd::tl->
                 	if p = "" then (true,[],line) else
                    let (x,xs) = cut p in
                    if xs = "" && hd = x then (true,[x],tl)
                    else if hd = x then 
                        let (b,m,r) = matchAtStartRE tl (Str xs) in 
                        if b then (b,x::m,r) else (b,[],[])
                    else
                        (false,[],[]))

      | Class p -> searchStringMatch (list_of_string p) line

      | NClass p ->  searchStringNotMatch (list_of_string p) line

      | Any -> (match line with 
               | [] -> (false,[],[])
               | hd::tl-> (true,[hd],tl))

      | ZeroOrMore e -> (match matchAtStartRE line e with
                        | (false,[],[]) -> (true,[],line)
                        | (true,m,r) -> let (_,m2,r2)= matchAtStartRE r (ZeroOrMore e) in
                                        (true,m@m2,r2)
                        | (_,_,_) -> (false, [], []))

      | ZeroOrOne e -> matchAtStartRE line (Repeat(0,1,e))

      | OneOrMore e -> (match matchAtStartRE line e with
                        | (false,[],[]) -> (false,[],[])
                        | (true,m,r) -> let (_,m2,r2) = matchAtStartRE r (ZeroOrMore e) in
                                        (true,m@m2,r2)
                        | (_,_,_) -> (false, [], []))

      | Or(p,q) -> let (b1,m1,r1) = matchAtStartRE line p in
                    let (b2,m2,r2) = matchAtStartRE line q in
                   if (List.length m1) > (List.length m2)  then (b1,m1,r1) else (b2,m2,r2)

      | Seq(p,q) -> let (b1,m1,r1) = matchAtStartRE line p in
                    if b1 then 
                        let (b2,m2,r2) = matchAtStartRE r1 q in 
                        if b2 then 
                            (true,m1@m2,r2)
                        else (false, [], []) 
                    else (false, [], [])
 
      | Not e -> (match matchAtStartRE line e with 
                 | (false,[],[]) -> matchAtStartRE line (Zero e)
                 | (_,_,_) -> (false,[],[]))

      | Repeat(m,n,p) -> if m > n then (false,[],[]) else if n = 0 && m = 0 then (true,[],line) else
                             match matchAtStartRE line p with
                        | (false,_,_) -> if n >= 0 && m <= 0 then (true,[],line) else (false,[],[])

                        | (true,x,y) -> if n > 1 then
                        					let (b,x2,y2) = matchAtStartRE y (Repeat((m-1),(n-1),p)) in
                                            if b then (true,x@x2,y2) else (false,[],[])
                                        else
                                        	(true,x,y)
;;

let matchAtStart line re =
    let (b,m,r) = matchAtStartRE (list_of_string line) re in
        (b, string_of_list m, string_of_list r)
;;
(* firstMatch *)

let rec firstMatchRE line re =
    match line with 
    | [] -> (false,[],[],[])
    | hd::tl -> let (b,r,e) = matchAtStartRE line re in 
                    if b then (b,[],r,e) else 
                    let (x,y,w,z) = firstMatchRE tl re in  
                     if x then (x,hd::y,w,z) else (false,[],[],[])

;;

let firstMatch line re =
    let (b,p,m,r) = firstMatchRE (list_of_string line) re in
        (b, string_of_list p, string_of_list m, string_of_list r)
;;


(* allMatches *)

let rec insert a b l = 
    match l with
    | [] -> []
    | (a2,b2,c)::tl -> (a@b@a2,b2,c) :: (insert a b tl)
;;

let rec allMatchesRE line re =
    match firstMatchRE line re with 
    | (false,a,b,c) ->  []
    | (true,a,b,c) ->  if List.length b = 0 then 
                        match c with 
                        |[] -> []
                        |[x] -> [(a,b,c);(a@c,[],[])]
                        |hd::tl-> (a,b,c) :: (insert [hd] b (allMatchesRE tl re)) 
                        else
                        (a,b,c) :: (insert a b (allMatchesRE c re))  
                     
;;

let allMatches line re =
    List.map
        (fun (p,m,r) -> (string_of_list p, string_of_list m, string_of_list r))
        (allMatchesRE (list_of_string line) re)
;;


let rec allMatches2RE line re =
    match firstMatchRE line re with 
    | (false,_,_,_) -> []
    | (true,a,b,c) ->  if List.length b = 0 then 
    					match c with 
    					| [] -> [] 
    					| [x] -> [([x],[],[])]
    					| hd::tl ->  let res = allMatches2RE tl re in 
    								(match res with
    									| [] -> [(a,b,c)]
    									| [(a2,b2,c2)] -> [(a,b,c);([hd],b2,a2);(a2,[],[])]
    									| (a2,b2,c2)::tl2 -> (a,b,c)::(hd::a2,b2,c2)::tl2 
    								) 
    					else		
    					(a,b,c) :: (allMatches2RE c re)
                     
;;

(* replaceAllMatches *)
let rec substitute l rpl line = 
    match l with
    |[] -> line
    |[(x,y,z)] -> x@rpl@z
    | (x,y,z)::tl -> x@rpl@(substitute tl rpl line)

;;

let rec replaceAllMatchesRE line rpl re =
    let l = allMatches2RE line re in 
        substitute l rpl line
;;

let replaceAllMatches line rpl re =
    let lineStr = list_of_string line in
      let rplStr = list_of_string rpl in
        let res = replaceAllMatchesRE lineStr rplStr re in
          string_of_list res
;;


(* allMatchesFile *)
let rec fileReader ni re = 
    try
        let s = input_line ni in
        let res = allMatches s re in
         res :: fileReader ni re 
    with 
        End_of_file -> []
;;

let allMatchesFile ni re =
    let input = open_in ni in
        let result = fileReader input re in
            close_in input; result 
;;


(* allMatchesOverlap *)

let rec allMatchesOverlapRE line re =
    match firstMatchRE line re with 
    | (false,_,_,_) -> []
    | (true,a,hd::tl,c) ->  if tl <> [] 
    						then (a,hd::tl,c) :: (insert a tl (allMatchesOverlapRE (tl@c) re))
    						else (a,[hd],c) :: (insert a [hd] (allMatchesOverlapRE c re))
    | (true,a,b,c) ->  (a,b,c) :: (insert a b (allMatchesOverlapRE c re))
;;

let allMatchesOverlap line re =
    List.map
        (fun (p,m,r) -> (string_of_list p, string_of_list m, string_of_list r))
        (allMatchesOverlapRE (list_of_string line) re)
;;





(* matchAtStartGreedyRE *)
let rec insert2 a l = 
    match l with
    | [] -> []
    | (b,m,r)::tl -> (b,a@m,r) :: (insert2 a tl)
;;

let maxTupel t1 t2 = 
    let (_,a1,_) = t1 in 
    let  (_,a2,_) = t2 in 
    if (List.length a1) > (List.length a2) then t1 else t2
;;

let rec biggestE l = 
    match l with 
    [] -> (false,[],[])
    | (false,_,_)::tl -> biggestE tl 
    | (true,a,b)::tl  -> maxTupel (true,a,b) (biggestE tl)
;;


let rec matchAtStartAllRE line re=
    match re with
      | Zero p -> [(true, [], line)]
      | Str p -> (match line with
                 | [] -> []
                 | hd::tl-> 
                    let (x,xs) = cut p in
                    if xs = "" && hd = x then [(true,[x],tl)]
                    else if hd = x then 
                        match matchAtStartAllRE tl (Str xs) with
                        [] -> []
                        | (b,m,r)::tl ->
                        if b then [(b,x::m,r)] else [(b,[],[])]
                    else
                        [(false,[],[])])

      | Class p -> [searchStringMatch (list_of_string p) line]

      | NClass p ->  [searchStringNotMatch (list_of_string p) line]

      | Any -> (match line with 
               | [] -> []
               | hd::tl-> [(true,[hd],tl)])

      | OneOrMore e -> (match matchAtStartAllRE line e with
                        | [] -> []
                        | (false,_,_)::tl -> []
                        | (true,m,r)::tl -> (true,m,r)::(insert2 m (matchAtStartAllRE r (OneOrMore e))))

    | ZeroOrMore e -> matchAtStartAllRE line (Repeat(0,List.length line,e))

    | ZeroOrOne e -> matchAtStartAllRE line (Repeat(0,1,e))

    | Repeat(m,n,p) -> (match matchAtStartAllRE line p with
    					| [] -> [] 
    					| tl -> let (b,_,_) = (biggestE tl) in
    							if b = false then [] else
    							if n > 0 && m = 0 then 
    								(true,[],line) :: (tl @ (listT tl (Repeat((m-1),(n-1),p))))
    							else if n > 0  then
    								if m <= 1 then
    								tl @ (listT tl (Repeat((m-1),(n-1),p)))
    							else listT tl (Repeat((m-1),(n-1),p))
    							else [])


    | Seq(p,q) -> let l =  matchAtStartAllRE line p  in 
                        listT l q 

    | Or(p,q) -> let (a,b,c) = biggestE (matchAtStartAllRE line p) in 
                 let (a2,b2,c2) = biggestE (matchAtStartAllRE line q) in 
                 if (List.length  b) >= (List.length  b2)  then [(a,b,c)]
                 else [(a2,b2,c2)] 

    | Not(e) -> (match biggestE(matchAtStartAllRE line e) with 
                 | (false,[],[]) -> matchAtStartAllRE line (Zero e)
                 | (_,_,_) -> [(false,[],[])])

    and listT l q = 
            match l with 
            [] -> []
            |(true,m,r)::tl ->  (insert2 m (matchAtStartAllRE r q)) @ (listT tl q) 
            |(false,_,_)::tl -> (listT tl q)

;;


let matchAtStartGreedyRE line re =
    let l = matchAtStartAllRE line re in 
        biggestE l 
;;

let matchAtStartGreedy line re =
    let (b,m,r) = matchAtStartGreedyRE (list_of_string line) re in
        (b, string_of_list m, string_of_list r)
;;



