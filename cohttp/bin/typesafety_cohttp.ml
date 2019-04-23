open Lwt

module Code = Cohttp.Code
module Client = Cohttp_lwt_unix.Client
module Response = Cohttp.Response

let status_code_of res = res |> Response.status |> Code.code_of_status

let is_success res = status_code_of res |> Code.is_success

let to_result (res, body) =
  let open Lwt in
  let string_of_body body = body |> Cohttp_lwt.Body.to_string in
  let with_status_code res_body =
    let code = (status_code_of res) in
    if is_success res then
      Lwt.return_ok (code, res_body)
    else
      Lwt.return_error (code, res_body) in
  (string_of_body body) >>= with_status_code

let get uri =
  Client.get uri  >>= to_result

let () =
  match Lwt_main.run (get (Uri.of_string "https://www.google.com/?hl=ja")) with
    | Ok (code, _) -> print_endline (string_of_int code)
    | Error (code, body) -> print_endline ((string_of_int code) ^ "\n" ^ body)
