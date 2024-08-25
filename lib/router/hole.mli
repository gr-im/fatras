(** A hole is used to describe a variable in the pattern of an URL's path. It is
    a type parameterised by a normal form (the type of the hole). For example,
    if a URL wants to capture an integer, the hole will be of type [int Hole.t]. *)

(** {1 Type}

    An (URL) pattern is a collection of constant fragments and holes, which can
    be typed. *)

type 'a t
(** The type that describes a hole. *)

val make : from_string:(string -> 'a option) -> to_string:('a -> string) -> 'a t
(** Under the bonnet, a hole is a function pair that allows you to go from a
    string to an arbitrary value and from an arbitrary value to a string. *)

(** {1 Hole composition} *)

val invmap : ('a -> 'b) -> ('b -> 'a) -> 'a t -> 'b t
(** A hole is an invariant functor (both covariant in ['a] and contravariant in
    ['a]). By giving a pair of projection functions, we can produce new holes. *)

val guard : 'a t -> ('a -> bool) -> 'a t
(** [guard hole pred] complete a hole with a predicate. *)

(** {2 Pre-defined holes}

    Sets of predefined holes and common holes. *)

val string : string t
(** [string] it describes a hole capturing string. *)

val int : int t
(** [int] it describes a hole capturing int. *)

val float : float t
(** [float] it describes a hole capturing float. *)

val bool : bool t
(** [bool] it describes a hole capturing bool. *)

val char : char t
(** [char] it describes a hole capturing char. *)

(** {1 Running holes} *)

val to_string : 'a t -> 'a -> string
(** [to_string hole value] converts a value holded by a hole into a string. *)

val from_string : 'a t -> string -> 'a option
(** [from_string hole str] try to converts a string to a value holded by a hole. *)
