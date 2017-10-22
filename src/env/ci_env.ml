(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Github

module type S = sig
  (** Return true for current environment *)
  val is_current: unit -> bool

  (** It checks whether it is a pull request and returns true if it is a pull request *)
  val is_pull_request: unit -> bool

  val github_user: unit -> User.t option

  (** Return personal token of Github *)
  val github_token: unit -> (Token.t, string) result

  (** Return pull request number of github *)
  val pull_request_number: unit -> (Pull_request.t, string) result

  (** Return user name and repository slug *)
  val slug: unit -> (Slug.t, string) result

  (** Return branch name *)
  val branch: unit -> (Branch.t, string) result

  (** Print environment variables *)
  val print_env_vals: f:((string * string) -> unit) -> unit
end

module Make (Ci_service: Ci_service_env.S) (Adapter: Env_adapter.S): S = struct
  include Ci_service
  module E = Sys_env.Make(Adapter)
  module G = Github_env.Make(Adapter)

  let github_user = G.github_user
  let github_token = G.github_token

  let print_env_vals ~f =
    E.print ~f ~secures:G.variables Ci_service.variables
end
