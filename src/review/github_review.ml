(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Env
open Typechecker
open Misc

type skip_result =
  | NoError
  | NotPullRequest

type review_result =
  | Skiped of skip_result
  | Reviewed of Github_t.review_result

module type S = sig
  val create: Typechecker_check_t.result -> (review_result, string) result
end

module Make(Supports_ci: Ci_detector.Supports_ci.S) (Adapter: Env_adapter.S) (Http_client: Http_client.S): S = struct
  module D = Ci_detector.Make(Supports_ci) (Adapter)
  module G = Github_client.Make(Http_client)

  let github_user ci ~f =
    let module Ci = (val ci: Ci_env.S) in
    let github_user = Ci.github_user () in
    Ok (f ~user:github_user)

  let github_token ci ~f =
    let module Ci = (val ci: Ci_env.S) in
    match Ci.github_token () with
      | Ok token -> Ok (f ~token)
      | Error e -> Error e

  let slug ci ~f =
    let open Github in
    let module Ci = (val ci: Ci_env.S) in
    match Ci.slug () with
      | Ok slug -> Ok (f ~slug:slug)
      | Error e -> Error e

  let branch ci ~f =
    let module Ci = (val ci: Ci_env.S) in
    match Ci.branch () with
      | Ok branch -> Ok (f ~branch)
      | Error e -> Error e

  let pull_request_number ci ~f =
    let module Ci = (val ci: Ci_env.S) in
    match Ci.pull_request_number () with
      | Ok num -> Ok (f ~num)
      | Error e -> Error e

  let bind_with o ~f ~ci =
    match o with
      | Ok bind_f -> f ci ~f:bind_f
      | Error e -> Error e

  (*
    val f: user:string ->
      token:string ->
      slug:string ->
      branch:string ->
      num:int ->
      Typechecker_check_t.result ->
      (review_result, string) result

    to

    Typechecker_check_t.result -> (review_result, string) result
  *)
  let bind_ci_env_vars f ~ci =
    let bind f = bind_with ~f ~ci in
    f |>
    bind github_user |>
    bind github_token |>
    bind slug |>
    bind branch |>
    bind pull_request_number

  let post_review o =
    let open Github_t in
    match Lwt_main.run o with
      | Ok (code, body) -> Ok (Reviewed (Github_j.review_result_of_string body))
      | Error (code, body) -> Error ((string_of_int code) ^ ":" ^ body)

  let post_review_comment json ~ci =

    let post_review_comment ~user ~token ~slug ~branch ~num json =
      let comment_of json = Review_comment.create ~slug ~branch json in
      let review_comment_by comment = G.create_review ?user ~token ~slug ~num comment in
      comment_of json |> review_comment_by |> post_review in

    let review = bind_ci_env_vars (Ok post_review_comment) ~ci in

    match review with
      | Ok f -> f json
      | Error e -> Error e

  let create json =
    let debug ci =
      let module Ci = (val ci: Ci_env.S) in
      Log.debug "Environment variables:\n";
      Ci.print_env_vals ~f:(fun (k, v) -> Log.debug "%s = %s\n" k v) in

    let review_by json ~ci =
      let module Ci = (val ci: Ci_env.S) in
      if Ci.is_pull_request () then
        post_review_comment json ~ci
      else
        Ok (Skiped NotPullRequest) in

    match D.detect () with
      | Ok ci -> debug ci; review_by json ~ci
      | Error e -> Error e
end
