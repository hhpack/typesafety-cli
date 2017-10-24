(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

module Source_name: sig
  type t = string
  val equal: 'a -> 'a -> bool
  val hash: 'a -> int
end

type key = Source_name.t
and 'a t = 'a MoreLabels.Hashtbl.Make(Source_name).t

val create : int -> 'a t
val add : 'a t -> key:key -> data:'a -> unit
val find : 'a t -> key -> 'a
val mem : 'a t -> key -> bool
val length : 'a t -> int
