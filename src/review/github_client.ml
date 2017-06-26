(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Github

module type S = sig
  val create_review: token:Token.t ->
    user:User.t ->
    repo:Repository.t ->
    num:Pull_request.t ->
    string ->
    (int * string, int * string) Result.result Lwt.t
end

module Make(Http_client: Http_client.S): S = struct
  let endpoint = "https://api.github.com"
  let repo_endpoint = endpoint ^ "/repos"
  let uri_of_review ~user ~repo ~num =
    let review_path = Printf.sprintf "/%s/%s/pulls/%d/reviews" user repo num in
    Uri.of_string (repo_endpoint ^ review_path)

  let headers_of_review ?(headers=[]) ~token ~user () =
    let defaults_headers = [
      ("User-Agent", user);
      ("Authorization", ("token " ^ token));
      ("Accept", "application/vnd.github.black-cat-preview+json")
    ] in
    ListLabels.concat [headers; defaults_headers]

  let create_review ~token ~user ~repo ~num content =
    let open Github_t in
    let review_comment = { body=content; event="REQUEST_CHANGES"; comments=None } in
    let uri = uri_of_review ~user ~repo ~num in
    let headers = headers_of_review ~token ~user () in
    let body = Github_j.string_of_review review_comment in
    Http_client.post uri ~headers ~body
end

include Make(Http_client)
