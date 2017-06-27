(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

(** Module interface of supoort ci environments *)
module Supports_ci: sig
  module type S = sig
    val supports: (module Ci_service_env.S) list
  end
end

(** Module interface of CI environment detector *)
module type S = sig
  val supports: (module Ci_service_env.S) list
  val detect: unit -> ((module Ci_env.S), string) result
end

module Make (S: Supports_ci.S): S

val supports: (module Ci_service_env.S) list
val detect: unit -> ((module Ci_env.S), string) result
