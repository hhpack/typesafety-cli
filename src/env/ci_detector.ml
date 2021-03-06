(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

(** Module interface of supoort ci environments *)
module Supports_ci = struct
  module type S = sig
    val supports: (module Ci_service_env.Service) list
  end
end

(** Module interface of CI environment detector *)
module type S = sig
  val supports: (module Ci_service_env.Service) list
  val detect: unit -> ((module Ci_env.S), string) result
end

module Make(S: Supports_ci.S) (Adapter: Env_adapter.S): S = struct
  let supports = S.supports
  let detect () =
    let detect_env env =
      let module E = (val env: Ci_service_env.Service) in
      E.is_current (module Adapter) in

    match ListLabels.find_opt ~f:detect_env supports  with
      | Some ci_service ->
        let module Detected_CI = (val ci_service: Ci_service_env.Service) in
        let module CI = Ci_env.Make(Detected_CI) (Adapter) in
        Ok (module CI: Ci_env.S)
      | None -> Error "Sorry, this is an environment not support"

end
