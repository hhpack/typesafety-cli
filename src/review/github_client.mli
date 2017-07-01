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

module Make(Http_client: Http_client.S): S
