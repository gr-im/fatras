(** Describes a pattern used to construct or interpret URLs. A pattern
    generically describes the path of a URL by adding holes that can be
    provisioned or interpreted.

    {k@ocaml[
    # 10 = 11 ;;
    ]k}
*)

(** {1 Types} *)

type ('continuation, 'witness) t
(** The type describing a pattern.

    The ['continuation] parameter captures all the holes described in the
    pattern and produces a function of type ['a -> 'witness]. *)

type ('hole, 'continuation, 'witness) hole =
  ?guard:('hole -> bool) ->
  ('continuation, 'witness) t ->
  ('hole -> 'continuation, 'witness) t

(** {1 Building patterns}

    Constructing a pattern allows us to describe a bi-directional schema,
    enabling us to generate the URL corresponding to a pattern, but also to
    interpret it (read a given string and extract the values at the position of
    the holes). *)

val make : (('k, 'k) t -> 'b) -> 'b

val h :
  ?guard:('hole -> bool) ->
  'hole Hole.t ->
  ('continuation, 'witness) t ->
  ('hole -> 'continuation, 'witness) t

val string : (string, 'continuation, 'witness) hole
val int : (int, 'continuation, 'witness) hole
val float : (float, 'continuation, 'witness) hole
val char : (char, 'continuation, 'witness) hole
val bool : (bool, 'continuation, 'witness) hole
val s : string -> ('continuation, 'witness) t -> ('continuation, 'witness) t
val eop : ('witness, 'witness) t
val inspect : ('a, 'b) t -> string
val ( / ) : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b
