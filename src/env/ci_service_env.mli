(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

module type S = sig
  (** Return enviroment variable names *)
  val variables: string list

  (** Return true for current environment *)
  val is_current: unit -> bool

  (** It checks whether it is a pull request and returns true if it is a pull request *)
  val is_pull_request: unit -> bool

  (** Return pull request number of github *)
  val pull_request_number: unit -> (Github.Pull_request.t, string) result

  (** Return user name and repository slug *)
  val slug: unit -> (Github.Slug.t, string) result

  (** Return branch name *)
  val branch: unit -> (Github.Branch.t, string) result
end

module type Service = sig
  val is_current: (module Env_adapter.S) -> bool
  module Make(Adapter: Env_adapter.S): S
end

(** Travis CI *)
module Travis: Service

(** General CI *)
module General: Service
