type tree = Nil | Node of int * tree * tree ;;

val make : int list -> tree
val max : tree -> int
val load : string -> tree
val store : string -> tree -> unit
(*val show : tree -> unit*)
