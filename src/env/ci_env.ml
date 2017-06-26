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
  val print: f:((string * string) -> unit )-> unit
end

module Travis = struct
  module Make(Env_s: Env.S): S = struct
    module E = Env.Make(Env_s)

    let variables = [
      "TRAVIS";
      "TRAVIS_PULL_REQUEST";
      "TRAVIS_PULL_REQUEST_SLUG";
      "TRAVIS_PULL_REQUEST_BRANCH";
      "GITHUB_TOKEN"
    ]

    let is_current () =
      E.is_enabled "TRAVIS"

    let is_pull_request () =
      match E.get "TRAVIS_PULL_REQUEST" with
        | Some v -> if v = "false" then  false else true
        | None -> false

    let token () =
      E.require "GITHUB_TOKEN"

    let pull_request_number () =
      E.require_map "TRAVIS_PULL_REQUEST" ~f:int_of_string

    let slug () =
      E.require_map "TRAVIS_PULL_REQUEST_SLUG" ~f:Slug.of_string

    let branch () =
      E.require "TRAVIS_PULL_REQUEST_BRANCH"

    let print ~f = E.print ~f ~secures:["GITHUB_TOKEN"] variables

  end
  include Make(Env.Sys_env)
end

module General = struct
  module Make(Env_s: Env.S): S = struct
    module E = Env.Make(Env_s)

    let variables = [
      "CI";
      "CI_PULL_REQUEST";
      "CI_PULL_REQUEST_SLUG";
      "CI_PULL_REQUEST_BRANCH";
      "GITHUB_TOKEN"
    ]

    let is_current () =
      E.is_enabled "CI"

    let is_pull_request () =
      match E.get "CI_PULL_REQUEST" with
        | Some v -> if v = "false" then false else true
        | None -> false

    let token () =
      E.require "GITHUB_TOKEN"

    let pull_request_number () =
      E.require_map "CI_PULL_REQUEST" ~f:int_of_string

    let slug () =
      E.require_map "CI_PULL_REQUEST_SLUG" ~f:Slug.of_string

    let branch () =
      E.require "CI_PULL_REQUEST_BRANCH"

    let print ~f = E.print ~f ~secures:["GITHUB_TOKEN"] variables
  end
  include Make(Env.Sys_env)
end
