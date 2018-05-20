(* Expressions module body *)

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

type exp =
      Add of exp*exp
    | Sub of exp*exp
    | Mult of exp*exp
    | Div of exp*exp
    | Const of float
    | V
    | Poly of float list
;;

let epsilon = 0.000001;;
let step = 0.1;;

let feq f1 f2 =
    abs_float(f1 -. f2) <= epsilon
;;

let rec pcountRes l = 
    match l with
    | [] -> (0,0)
    | [0.0] -> (0,1)
    | hd::tl -> let (x,y) = pcountRes tl in 
                    if hd > 0.0 then (x+1,y)
                    else if y > 0 && x = 0 then (x,y+1)
                    else (x,y) 
                
;; 


let pcount l =
    pcountRes l;
;;


let rec sizeRec e = 
    match e with
     | V -> 1
     | Const(_) -> 1
     | Add(l,r) -> 1 + (sizeRec l) + (sizeRec r)
     | Sub(l,r) -> 1 + (sizeRec l) + (sizeRec r)
     | Mult(l,r) -> 1 + (sizeRec l) + (sizeRec r)
     | Div(l,r) -> 1 + (sizeRec l) + (sizeRec r) 
     | Poly(l) -> let (x,y) = pcount l in 1 + x + y
;;
let size e =
    sizeRec e
;;

let rec evalRec v e = 
    match e with
    | V -> v
    | Const(x) -> x
    | Add(l,r) -> (evalRec v l) +. (evalRec v r)
    | Sub(l,r) -> (evalRec v l) -. (evalRec v r)
    | Mult(l,r) -> (evalRec v l) *. (evalRec v r)
    | Div(l,r) -> (evalRec v l) /. (evalRec v r)
    | Poly(l) -> polyCalc l 0.0 v

and polyCalc l t v  =
    match l with
    | []  -> 0.0
    | hd::tl ->  hd *. (v ** t) +. (polyCalc tl (t +. 1.0) v)
;;

let eval v e =
    evalRec v e
;;

let deriv e =
    failwith "deriv: not yet defined"
;;

let alike a n e1 e2 =
    failwith "alike: not yet defined"
;;

let newton s e =
    failwith "newton: not yet defined"
;;

let simpl e =
    failwith "simpl: not yet defined"
;;

let graph nx ny s e =
    failwith "graph: not yet defined"
;;

