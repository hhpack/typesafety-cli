(**
 * Copyright 2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

module Make(Supports_ci: Ci_detector.Supports_ci.S) (Http_client: Http_client.S) = struct
  (*
  type ('a, 'b) review_result =
    | Skiped of 'a
    | Reviewed of 'b*)

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

  let post_review_comment json ~ci =
    let post_review_comment ~token ~user ~repo ~branch ~num json =
      let comment_of json = Review_comment.create ~user ~repo ~branch json in
      let review_comment_by comment = G.create_review ~token ~user ~repo ~num comment in
        comment_of json |>
        review_comment_by |>
        fun o -> match Lwt_main.run o with
          | Ok (code, body) -> Ok ()
          | Error (code, body) -> Error ((string_of_int code) ^ ":" ^ body) in
    let review = bind_ci_env_vars (Ok post_review_comment) ~ci in
    match review with
      | Ok f -> f json
      | Error e -> Error e

  let create json =
    let review_by json ~ci =
      let module Ci = (val ci: Ci_env.S) in
      if Ci.is_pull_request () then
        post_review_comment json ~ci
      else
        Ok () in
    match D.detect () with
      | Ok ci -> review_by json ~ci
      | Error e -> Error e
end

include Make(Ci_detector)(Http_client)
