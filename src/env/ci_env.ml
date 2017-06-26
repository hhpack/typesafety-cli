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

  (** Return personal token of Github *)
  val token: unit -> (Token.t, string) result

  (** Return pull request number of github *)
  val pull_request_number: unit -> (Pull_request.t, string) result

  (** Return user name and repository slug *)
  val slug: unit -> (Slug.t, string) result

  (** Return branch name *)
  val branch: unit -> (Branch.t, string) result

  (** Print environment variables *)
  val print_env_vals: f:((string * string) -> unit) -> unit
end

module Make (Ci_service: Ci_service_env.S): S = struct
  let token = Github_env.token

  let is_current = Ci_service.is_current
  let is_pull_request = Ci_service.is_pull_request
  let pull_request_number = Ci_service.pull_request_number
  let slug = Ci_service.slug
  let branch = Ci_service.branch

  let print_env_vals ~f =
    Env.print ~f ~secures:Github_env.variables Ci_service.variables
end

(** Support ci environments *)
(* module Travis = Make(Ci_service_env.Travis) *)
(* module General = Make(Ci_service_env.General) *)
