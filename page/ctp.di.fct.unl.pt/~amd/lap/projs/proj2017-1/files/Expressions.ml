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


let pcount l =
    failwith "pcount: not yet defined"
;;

let size e =
    failwith "size: not yet defined"
;;

let eval v e =
    failwith "eval: not yet defined"
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

