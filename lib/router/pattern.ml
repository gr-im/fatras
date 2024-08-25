type 'continuation t =
  | Eop : unit t
  | Constant : string * 'continuation t -> 'continuation t
  | Hole : 'hole Hole.t * 'continuation t -> ('hole -> 'continuation) t

type ('hole, 'continuation) hole =
  ?guard:('hole -> bool) -> 'continuation t -> ('hole -> 'continuation) t

let h ?(guard = fun _ -> true) hole r = Hole (Hole.guard hole guard, r)
let string ?guard r = h ?guard Hole.string r
let int ?guard r = h ?guard Hole.int r
let float ?guard r = h ?guard Hole.float r
let char ?guard r = h ?guard Hole.char r
let bool ?guard r = h ?guard Hole.bool r
let s v r = Constant (v, r)
let eop = Eop
let make p1 = p1 eop
let ( / ) p1 p2 r = p1 (p2 r)

let inspect pattern =
  let rec aux : type k w. string -> k t -> string =
   fun acc -> function
    | Eop -> acc
    | Constant (s, xs) -> aux (acc ^ "/" ^ s) xs
    | Hole (_, xs) -> aux (acc ^ "/$hole") xs
  in
  aux "" pattern
