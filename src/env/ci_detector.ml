module Supports_ci = struct
  module type S = sig
    val supports: (module Ci_env.S) list
  end
end

module type S = sig
  val supports: (module Ci_env.S) list
  val detect: unit -> ((module Ci_env.S), string) result
end

module Make(S: Supports_ci.S): S = struct
  let supports = S.supports
  let detect () =
    let detect_env env =
      let module E = (val env: Ci_env.S) in
      E.is_current () in
    try
      Ok (ListLabels.find ~f:detect_env supports)
    with Not_found -> Error "Sorry, this is an environment not support"
end
