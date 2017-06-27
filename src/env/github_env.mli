(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

module type S = sig
  val variables: string list
  val github_user: unit -> Github.User.t option
  val github_token: unit -> (Github.Token.t, string) result
end

module Make (Env_s: Env.S) : S

val variables: string list
val github_user: unit -> Github.User.t option
val github_token: unit -> (Github.Token.t, string) result
