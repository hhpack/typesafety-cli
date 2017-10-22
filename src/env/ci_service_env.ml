(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Github

module type S = sig
  (** Return enviroment variable names *)
  val variables: string list

  (** Return true for current environment *)
  val is_current: unit -> bool

  (** It checks whether it is a pull request and returns true if it is a pull request *)
  val is_pull_request: unit -> bool

  (** Return pull request number of github *)
  val pull_request_number: unit -> (Pull_request.t, string) result

  (** Return user name and repository slug *)
  val slug: unit -> (Slug.t, string) result

  (** Return branch name *)
  val branch: unit -> (Branch.t, string) result
end

module type Service = sig
  module Make(Adapter: Env_adapter.S): S
end

(** Travis CI *)
module Travis: Service = struct
  module Make(Adapter: Env_adapter.S): S = struct
    include Sys_env.Make(Adapter)

    let variables = [
      "TRAVIS";
      "TRAVIS_PULL_REQUEST";
      "TRAVIS_PULL_REQUEST_SLUG";
      "TRAVIS_PULL_REQUEST_BRANCH";
    ]

    let is_current () = is_enabled "TRAVIS"

    let is_pull_request () =
      match get "TRAVIS_PULL_REQUEST" with
        | Some v -> if v = "false" then  false else true
        | None -> false

    let pull_request_number () =
      require_map "TRAVIS_PULL_REQUEST" ~f:Pull_request.of_string

    let slug () =
      require_map "TRAVIS_PULL_REQUEST_SLUG" ~f:Slug.of_string

    let branch () =
      require_map "TRAVIS_PULL_REQUEST_BRANCH" ~f:Branch.of_string
  end
end

(** General CI *)
module General: Service = struct
  module Make(Adapter: Env_adapter.S): S = struct
    include Sys_env.Make(Adapter)

    let variables = [
      "CI";
      "CI_PULL_REQUEST";
      "CI_PULL_REQUEST_SLUG";
      "CI_PULL_REQUEST_BRANCH";
    ]

    let is_current () = is_enabled "CI"

    let is_pull_request () =
      match get "CI_PULL_REQUEST" with
        | Some v -> if v = "false" then false else true
        | None -> false

    let pull_request_number () =
      require_map "CI_PULL_REQUEST" ~f:Pull_request.of_string

    let slug () =
      require_map "CI_PULL_REQUEST_SLUG" ~f:Slug.of_string

    let branch () =
      require_map "CI_PULL_REQUEST_BRANCH" ~f:Branch.of_string
  end
end
