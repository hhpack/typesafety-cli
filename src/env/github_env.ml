(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Github

module type S = sig
  val variables: string list

  (** Return user name of Github *)
  val github_user: unit -> User.t option

  (** Return personal token of Github *)
  val github_token: unit -> (Token.t, string) result
end

module Make(Adapter: Env_adapter.S): S = struct
  include Sys_env.Make(Adapter)

  let variables = [
    "GITHUB_USER";
    "GITHUB_TOKEN";
  ]

  let github_user () = get_map "GITHUB_USER" ~f:User.of_string
  let github_token () = require_map "GITHUB_TOKEN" ~f:Token.of_string
end
