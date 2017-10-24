(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

module type S = sig
  val get: string -> string option
  val get_map: string -> f:(string -> 'a) -> 'a option
  val is_enabled: string -> bool
  val require: ?failed:(string -> (string, string) result) ->
    string -> (string, string) result
  val require_map: string -> f:(string -> 'a) -> ('a, string) result
  val print: ?secures:string list ->
    f:(string * string -> unit) -> string list -> unit
end

module Make (Adapter: Env_adapter.S): S
