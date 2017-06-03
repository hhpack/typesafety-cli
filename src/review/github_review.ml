(**
 * Copyright 2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

module Make(Supports_ci: Ci_detector.Supports_ci.S) (Http_client: Http_client.S) = struct
  type skip_result =
    | NoError
    | NotPullRequest

  type review_result =
    | Skiped of skip_result
    | Reviewed of Github_t.review_result

  module D = Ci_detector.Make(Supports_ci)
  module G = Github_client.Make(Http_client)

  let token ci ~f =
    let module Ci = (val ci: Ci_env.S) in
    match Ci.token () with
      | Ok token -> Ok (f ~token)
      | Error e -> Error e

  let slug ci ~f =
    let module Ci = (val ci: Ci_env.S) in
    match Ci.slug () with
      | Ok slug ->
        let user, repo = slug in
        Ok (f ~user ~repo)
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

  let bind_ci_env_vars f ~ci =
    let bind f = bind_with ~f ~ci in
    f |>
    bind token |>
    bind slug |>
    bind branch |>
    bind pull_request_number

  let post_review o =
    let open Github_t in
    match Lwt_main.run o with
      | Ok (code, body) -> Ok (Reviewed (Github_j.review_result_of_string body))
      | Error (code, body) -> Error ((string_of_int code) ^ ":" ^ body)

  let post_review_comment json ~ci =
    let post_review_comment ~token ~user ~repo ~branch ~num json =
      let comment_of json = Review_comment.create ~user ~repo ~branch json in
      let review_comment_by comment = G.create_review ~token ~user ~repo ~num comment in
        comment_of json |>
        review_comment_by |>
        post_review in
    let review = bind_ci_env_vars (Ok post_review_comment) ~ci in
    let review_if_has_errors json ~f =
      let open Typechecker_check_t in
      if json.passed then
        Ok (Skiped NoError)
      else
        f json in

    match review with
      | Ok f -> review_if_has_errors ~f json
      | Error e -> Error e

  let create json =
    let review_by json ~ci =
      let module Ci = (val ci: Ci_env.S) in
      if Ci.is_pull_request () then
        post_review_comment json ~ci
      else
        Ok (Skiped NotPullRequest) in
    match D.detect () with
      | Ok ci -> review_by json ~ci
      | Error e -> Error e
end

include Make(Ci_detector)(Http_client)
