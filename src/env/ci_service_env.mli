(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

module type S = sig
  val variables: string list
  val is_current: unit -> bool
  val is_pull_request: unit -> bool
  val pull_request_number: unit -> (Github.Pull_request.t, string) result
  val slug: unit -> (Github.Slug.t, string) result
  val branch: unit -> (Github.Branch.t, string) result
end

(** Travis CI *)
module Travis: sig
  module Make(Env_s: Sys_env.S): S
  val variables: string list
  val is_current: unit -> bool
  val is_pull_request: unit -> bool
  val pull_request_number: unit -> (Github.Pull_request.t, string) result
  val slug: unit -> (Github.Slug.t, string) result
  val branch: unit -> (Github.Branch.t, string) result
end

(** General CI *)
module General: sig
  module Make(Env_s: Sys_env.S): S
  val variables: string list
  val is_current: unit -> bool
  val is_pull_request: unit -> bool
  val pull_request_number: unit -> (Github.Pull_request.t, string) result
  val slug: unit -> (Github.Slug.t, string) result
  val branch: unit -> (Github.Branch.t, string) result
end
