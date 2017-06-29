(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

(** Module interface of supoort ci environments *)
module Supports_ci = struct
  module type S = sig
    val supports: (module Ci_service_env.S) list
  end
end

(** Module interface of CI environment detector *)
module type S = sig
  val supports: (module Ci_service_env.S) list
  val detect: unit -> ((module Ci_env.S), string) result
end

module Make(S: Supports_ci.S): S = struct
  let supports = S.supports
  let detect () =
    let detect_env env =
      let module E = (val env: Ci_service_env.S) in
      E.is_current () in
    try
      let ci_service = ListLabels.find ~f:detect_env supports in
      let module Detected_CI = (val ci_service: Ci_service_env.S) in
      let module CI = Ci_env.Make(Detected_CI) in
      Ok (module CI: Ci_env.S)
    with Not_found -> Error "Sorry, this is an environment not support"
end

module Current_supports = Make(struct
  open Ci_service_env

  let supports = [
    (module Travis: S);
    (module General: S)
  ]
end)
