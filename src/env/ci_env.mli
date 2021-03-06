(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

module type S = sig
  (** Return true for current environment *)
  val is_current: unit -> bool

  (** It checks whether it is a pull request and returns true if it is a pull request *)
  val is_pull_request: unit -> bool

  val github_user: unit -> Github.User.t option

  (** Return personal token of Github *)
  val github_token: unit -> (Github.Token.t, string) result

  (** Return pull request number of github *)
  val pull_request_number: unit -> (Github.Pull_request.t, string) result

  (** Return user name and repository slug *)
  val slug: unit -> (Github.Slug.t, string) result

  (** Return branch name *)
  val branch: unit -> (Github.Branch.t, string) result

  (** Print environment variables *)
  val print_env_vals: f:((string * string) -> unit) -> unit
end

module Make (Ci_service: Ci_service_env.Service) (Adapter: Env_adapter.S): S
