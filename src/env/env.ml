module type S = sig
  val get: string -> string option
end

module Sys_env: S = struct
  let get key =
    try
      Some (Sys.getenv key)
    with _ -> None
end

module Make(S: S) = struct
  let require_failed key = Error (key ^ " is required")
  let get key = S.get key

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
    match S.get key with
      | Some v -> Ok v
      | None -> failed key

  (** Get environment variable, apply function f and return *)
  let require_map key ~f =
    match require key with
      | Ok v -> Ok (f v)
      | Error v -> Error v
end

include Make(Sys_env)
