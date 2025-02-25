(* RegExp module body *)

(* 
Aluno 1: ????? mandatory to fill
Aluno 2: ????? mandatory to fill

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


(* matchAtStart *)

let rec matchAtStartRE line re =
    match re with
      | Zero p -> (true, [], line)
      | _ -> (false, [], [])
;;

let matchAtStart line re =
    let (b,m,r) = matchAtStartRE (list_of_string line) re in
        (b, string_of_list m, string_of_list r)
;;


(* firstMatch *)

let rec firstMatchRE line re =
    (false,[],[],[])
;;

let firstMatch line re =
    let (b,p,m,r) = firstMatchRE (list_of_string line) re in
        (b, string_of_list p, string_of_list m, string_of_list r)
;;


(* allMatches *)

let rec allMatchesRE line re =
    []
;;

let allMatches line re =
    List.map
        (fun (p,m,r) -> (string_of_list p, string_of_list m, string_of_list r))
        (allMatchesRE (list_of_string line) re)
;;


(* replaceAllMatches *)

let rec replaceAllMatchesRE line rpl re =
    []
;;

let replaceAllMatches line rpl re =
    let lineStr = list_of_string line in
      let rplStr = list_of_string rpl in
        let res = replaceAllMatchesRE lineStr rplStr re in
          string_of_list res
;;


(* allMatchesFile *)

let allMatchesFile ni re =
    []
;;


(* allMatchesOverlap *)

let rec allMatchesOverlapRE line re =
    []
;;

let allMatchesOverlap line re =
    List.map
        (fun (p,m,r) -> (string_of_list p, string_of_list m, string_of_list r))
        (allMatchesOverlapRE (list_of_string line) re)
;;


(* matchAtStartGreedyRE *)

let matchAtStartGreedyRE line re =
    (false, [], [])
;;

let matchAtStartGreedy line re =
    let (b,m,r) = matchAtStartGreedyRE (list_of_string line) re in
        (b, string_of_list m, string_of_list r)
;;



