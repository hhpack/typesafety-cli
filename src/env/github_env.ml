(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Github

module type S = sig
  val variables: string list

  (** Return personal token of Github *)
  val token: unit -> (Token.t, string) result
end

module Make(Env_s: Env.S): S = struct
  include Env.Make(Env_s)

  let variables = [
    "GITHUB_TOKEN"
  ]

  let token () = require "GITHUB_TOKEN"
end
include Make(Env.Sys_env)
