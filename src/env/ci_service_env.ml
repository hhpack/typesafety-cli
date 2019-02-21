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
  val is_current: (module Env_adapter.S) -> bool
  module Make(Adapter: Env_adapter.S): S
end

let is_current adapter name =
  let module Adapter = (val adapter: Env_adapter.S) in
  match Adapter.get name with
    | Some v -> bool_of_string v
    | None -> false

(** Travis CI *)
module Travis: Service = struct
  let is_current adapter =
    let module Env_adapter = (val adapter: Env_adapter.S) in
    is_current (module Env_adapter) "TRAVIS"

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


(** Circle CI *)
module Circle_ci: Service = struct
  let is_current adapter =
    let module Env_adapter = (val adapter: Env_adapter.S) in
    is_current (module Env_adapter) "CIRCLECI"

  module Make(Adapter: Env_adapter.S): S = struct
    include Sys_env.Make(Adapter)

    let variables = [
      "CIRCLECI";
      "CIRCLE_PULL_REQUEST";
      "CIRCLE_PR_NUMBER";
      "CIRCLE_PROJECT_USERNAME";
      "CIRCLE_PROJECT_REPONAME";
      "CIRCLE_SHA1";
      "CIRCLE_BRANCH";
    ]

    let is_current () = is_enabled "CIRCLECI" (* replace to is_current *)

    let is_pull_request () =
      match get "CIRCLE_PULL_REQUEST" with
        | Some _ -> true
        | None -> false

    let pull_request_number () =
      require_map "CIRCLE_PR_NUMBER" ~f:Pull_request.of_string

    (* owner_name/repo_name *)
    let slug () =
     let user = require "CIRCLE_PROJECT_USERNAME" in
     let repo = require "CIRCLE_PROJECT_REPONAME" in
     match (user, repo) with
       | (Ok username, Ok repo) -> Ok (Slug.of_pair username repo)
       | (Ok _, Error e) -> Error e
       | (Error e, Ok _) -> Error e
       | (Error ue, Error re) -> Error (ue ^ "\n" ^ re)

    let branch () =
      require_map "CIRCLE_BRANCH" ~f:Branch.of_string
  end
end


(** General CI *)
module General: Service = struct
  let is_current adapter =
    let module Env_adapter = (val adapter: Env_adapter.S) in
    is_current (module Env_adapter) "CI"

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
