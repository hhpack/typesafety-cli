(**
 * Copyright 2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

module Code = Cohttp.Code
module Client = Cohttp_lwt_unix.Client
module Response = Cohttp.Response

module type S = sig
  val post: Uri.t ->
    headers:(string * string) list ->
    body:string ->
    (int * string, int * string) Result.result Lwt.t
end

let status_code_of res = res |> Response.status |> Code.code_of_status
let is_success res = status_code_of res |> Code.is_success
let to_result (res, body) =
  let open Lwt in
  let string_of_body body = body |> Cohttp_lwt_body.to_string in
  let with_status_code res_body =
    let code = (status_code_of res) in
    if is_success res then
      Lwt.return_ok (code, res_body)
    else
      Lwt.return_error (code, res_body) in
  (string_of_body body) >>= with_status_code

let post uri ~headers ~body =
  let open Lwt in
  let open Cohttp in
  let req_headers = Header.add_list (Header.init ()) headers in
  let req_body = `String body in
  Client.post uri ~body:req_body ~headers:req_headers >>= to_result
