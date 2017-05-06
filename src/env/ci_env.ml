type token = string
type branch_name = string

module Slug = struct
  type t = (string * string)
  let of_string s =
    let slug_len = String.length s in
    let slug_sp_index = String.index s '/' in
    let user = String.sub s 0 slug_sp_index in
    let repo_len = (slug_len - (String.length user) - 1) in
    let repo = String.sub s (slug_sp_index + 1) repo_len in
    (user, repo)
  let to_string t =
    let user, repo = t in
    user ^ "/" ^ repo
end

module type S = sig
  val is_current: unit -> bool
  val is_pull_request: unit -> bool
  val token: unit -> (token, string) result
  val pull_request_number: unit -> (int, string) result
  val slug: unit -> (Slug.t, string) result
  val branch: unit -> (branch_name, string) result
end

module Make(CI: S) = struct
  (** Return true for current environment *)
  let is_current () = CI.is_current ()

  (** It checks whether it is a pull request and returns true if it is a pull request *)
  let is_pull_request () = CI.is_pull_request ()

  (** Return personal token of Github *)
  let token () = CI.token ()

  (** Return pull request number of github *)
  let pull_request_number () = CI.pull_request_number ()

  (** Return user name and repository slug *)
  let slug () = CI.slug ()

  (** Return branch name *)
  let branch () = CI.branch ()
end

module Travis = struct
  module Make(Env_s: Env.S): S = struct
    module E = Env.Make(Env_s)
    let is_current () =
      match E.get "TRAVIS" with
        | Some v -> bool_of_string v
        | None -> false
    let is_pull_request () =
      match E.get "TRAVIS_PULL_REQUEST" with
        | Some v -> true
        | None -> false
    let token () =
      match E.require "GITHUB_TOKEN" with
        | Ok v -> Ok v
        | Error e -> Error e
    let pull_request_number () =
      match E.require "TRAVIS_PULL_REQUEST" with
        | Ok v -> Ok (int_of_string v)
        | Error e -> Error e
    let slug () =
      match E.require "TRAVIS_PULL_REQUEST_SLUG" with
        | Ok v -> Ok (Slug.of_string v)
        | Error e -> Error e
    let branch () = E.require "TRAVIS_PULL_REQUEST_BRANCH"
  end
  include Make(Env.Sys_env)
end

let supports =
  [(module Travis:S)]

let detect () =
  let detect_env env =
    let module E = (val env: S) in
    E.is_current () in
  try
    Ok (ListLabels.find ~f:detect_env supports)
  with Not_found -> Error "Sorry, this is an environment not support"
