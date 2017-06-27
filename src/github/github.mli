
module User : sig
  type t
  val is_empty : t -> bool
  val of_string : string -> t
  val to_string : t -> string
end

module Token : sig
  type t
  val is_empty : t -> bool
  val of_string : string -> t
  val to_string : t -> string
end

module Branch : sig
  type t
  val is_empty : t -> bool
  val of_string : string -> t
  val to_string : t -> string
end

module Repository : sig
  type t
  val is_empty : t -> bool
  val of_string : string -> t
  val to_string : t -> string
end

module Pull_request : sig
  type t
  val equal : t -> t -> bool
  val compare : t -> t -> int
  val to_int: t -> int
  val to_string : t -> string
  val of_string : string -> t
end

module Slug : sig
  type t
  val of_string : string -> t
  val repo_owner : t -> User.t
  val repo_name : t -> Repository.t
  val to_string : t -> string
end
