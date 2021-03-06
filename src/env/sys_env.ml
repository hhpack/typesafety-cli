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

module Index = struct
  include Map.Make(struct
      type t = string
      let compare = compare
    end)

  let from names =
    let rec add_all names m =
      match names with
        | [] -> m
        | hd::tail -> add_all tail (add hd true m) in
    add_all names empty
end

module Make(Adapter: Env_adapter.S): S = struct
  let require_failed key = Error (key ^ " is required")

  include Adapter

  (** Get environment variable, apply function f and return *)
  let get_map key ~f =
    match get key with
      | Some v -> Some (f v)
      | None -> None

  (**
     Check whether the environment variable is valid

     if is_enabled "DEBUG" then
      print_endline "debug mode"
     else
      print_endline"not debug mode"
  *)
  let is_enabled name =
    match get name with
      | Some v -> bool_of_string v
      | None -> false

  (** Get the environment variable *)
  let require ?(failed=require_failed) key =
    match get key with
      | Some v -> Ok v
      | None -> failed key

  (** Get environment variable, apply function f and return *)
  let require_map key ~f =
    match require key with
      | Ok v -> Ok (f v)
      | Error v -> Error v

  (** print env variables *)
  let print ?(secures = []) ~f variables =
    let secure_vals = Index.from secures in
    let mask k v =
      if Index.mem k secure_vals then
        (k, "[SECURE]")
      else (k, v) in
    let print_if_key_exists k ~f =
      match get k with
        | Some v -> f (mask k v)
        | None -> () in
    let print_env_v k = print_if_key_exists k ~f in
    ListLabels.iter ~f:print_env_v (List.concat [variables; secures])
end
