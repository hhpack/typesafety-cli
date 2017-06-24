open Github

module type S = sig
  val is_current: unit -> bool
  val is_pull_request: unit -> bool
  val token: unit -> (Token.t, string) result
  val pull_request_number: unit -> (Pull_request.t, string) result
  val slug: unit -> (Slug.t, string) result
  val branch: unit -> (Branch.t, string) result
  val print: f:((string * string) -> unit )-> unit
end

module Make(CI: S) = struct
  (** Return true for current environment *)
  let is_current = CI.is_current

  (** It checks whether it is a pull request and returns true if it is a pull request *)
  let is_pull_request = CI.is_pull_request

  (** Return personal token of Github *)
  let token = CI.token

  (** Return pull request number of github *)
  let pull_request_number = CI.pull_request_number

  (** Return user name and repository slug *)
  let slug = CI.slug

  (** Return branch name *)
  let branch = CI.branch

  let print = CI.print
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
