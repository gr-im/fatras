(** Describes a pattern used to construct or interpret URLs. A pattern
    generically describes the path of a URL by adding holes that can be
    provisioned or interpreted. *)

(**/**)

(**
   {k@ocaml[
    # open Router;;
    ]k}
*)

(**/**)

(** {1 Types} *)

type 'continuation t
(** The type describing a pattern.

    The ['continuation] parameter captures all the holes described in the
    pattern. *)

type ('hole, 'continuation) hole =
  ?guard:('hole -> bool) -> 'continuation t -> ('hole -> 'continuation) t
(** A shortcut for describing a typed hole in a pattern. *)

(** {1 Building patterns}

    Constructing a pattern allows us to describe a bi-directional schema,
    enabling us to generate the URL corresponding to a pattern, but also to
    interpret it (read a given string and extract the values at the position of
    the holes). *)

val make : (unit t -> 'b) -> 'b
(** [make pattern] build a new pattern.

    {k@ocaml[
    # let f  = Pattern.(make @@ s "user" / s "id" / int / string) ;;
    val f : (int -> string -> unit) Pattern.t = <abstr>
    ]k}
*)

val h :
  ?guard:('hole -> bool) ->
  'hole Hole.t ->
  'continuation t ->
  ('hole -> 'continuation) t
(** Construct a hole, for example, to describe a hole that characterises an
    integer greater than 10 directly into a pattern :

    {k@ocaml[
    # let f = Pattern.(
        make @@
          s "user" / s "id" / int / h ~guard:(fun x -> x > 10) Hole.int) ;;
    val f : (int -> int -> unit) Pattern.t = <abstr>
    ]k}
*)

(** {2 Building pattern fragment}

    Set of fragments used to compose a pattern. *)

val s : string -> 'continuation t -> 'continuation t
(** [s "value"] describes a constant fragment, a string. *)

val string : (string, 'continuation) hole
(** [string] describes a hole that captures a string. *)

val int : (int, 'continuation) hole
(** [int] describes a hole that captures an integer. *)

val float : (float, 'continuation) hole
(** [float] describes a hole that captures a float. *)

val char : (char, 'continuation) hole
(** [char] describes a hole that captures a character. *)

val bool : (bool, 'continuation) hole
(** [bool] describes a hole that captures a boolean. *)

val ( / ) : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b
(** [a / b] composes two pattern fragment. *)

(** {1 Util} *)

val inspect : 'a t -> string
(** [inspect pattern] gives a readable string representation of a pattern. *)
