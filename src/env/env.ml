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
  let get_with_default key ~default =
    match S.get key with
      | Some v -> v
      | None -> default
  let require ?(failed=require_failed) key =
    match S.get key with
      | Some v -> Ok v
      | None -> failed key
end

include Make(Sys_env)
