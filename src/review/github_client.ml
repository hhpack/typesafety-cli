(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Github

module type S = sig
  val create_review: ?user:User.t ->
    token:Token.t ->
    slug:Slug.t ->
    num:Pull_request.t ->
    string ->
    (int * string, int * string) Result.result Lwt.t
end

module Make(Http_client: Http_client.S): S = struct
  let endpoint = "https://api.github.com"
  let repo_endpoint = endpoint ^ "/repos"

  let uri_of_review ~slug ~num =
    let path_of_slug = (Slug.to_string slug) in
    let pull_req_num = (Pull_request.to_int num) in
    let review_path = Printf.sprintf "/%s/pulls/%d/reviews" path_of_slug pull_req_num in
    Uri.of_string (repo_endpoint ^ review_path)

  let headers_of_review ?(headers=[]) ~token ~user () =
    let defaults_headers = [
      ("User-Agent", (User.to_string user));
      ("Authorization", ("token " ^ (Token.to_string token)));
      ("Accept", "application/vnd.github.black-cat-preview+json")
    ] in
    ListLabels.concat [headers; defaults_headers]

  let user_for_header ?user ~slug =
    match user with
      | Some v -> v
      | None -> Slug.repo_owner slug

  let create_review ?user ~token ~slug ~num content =
    let open Github_t in
    let review_comment = { body=content; event="COMMENT"; comments=None } in
    let uri = uri_of_review ~slug ~num in
    let user_agent = (user_for_header ?user ~slug) in
    let headers = headers_of_review ~token ~user:user_agent () in
    let body = Github_j.string_of_review review_comment in
    Http_client.post uri ~headers ~body
end
