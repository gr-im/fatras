type 'a t = { from_string : string -> 'a option; to_string : 'a -> string }

let invmap map contramap { from_string; to_string } =
  let from_string x = x |> from_string |> Option.map map
  and to_string x = x |> contramap |> to_string in
  { from_string; to_string }

let guard { from_string; to_string } predicate =
  let from_string x =
    Option.bind (from_string x) (fun x -> if predicate x then Some x else None)
  in
  { from_string; to_string }

let make ~from_string ~to_string = { from_string; to_string }
let to_string { to_string; _ } = to_string
let from_string { from_string; _ } = from_string

let string =
  let from_string = Option.some and to_string = Fun.id in
  make ~from_string ~to_string

let int =
  let from_string = int_of_string_opt and to_string = string_of_int in
  make ~from_string ~to_string

let float =
  let from_string = float_of_string_opt and to_string = string_of_float in
  make ~from_string ~to_string

let bool =
  let from_string = bool_of_string_opt and to_string = string_of_bool in
  make ~from_string ~to_string

let char =
  let from_string s = if Int.equal (String.length s) 1 then Some s.[0] else None
  and to_string = String.make 1 in
  make ~from_string ~to_string
