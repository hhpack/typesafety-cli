open Typechecker_check_t

module Message = struct
  type t = error_detail

  let path_from ?(root=Sys.getcwd ()) t =
    Str.replace_first (Str.regexp (root ^ "/")) "" t.source_path

  let uri_of ?(root=Sys.getcwd ()) t =
    (path_from t ~root) ^ "#L" ^ (string_of_int t.source_line)
end

type t = {
  user: string;
  repo: string;
  branch: string;
  root: string;
}

let init ?(root=Sys.getcwd ()) ~user ~repo ~branch () =
  { user; repo; branch; root }

let title_of_source ?(level = 2) ~message =
  let rec h_level n =
    if n <= 0 then
      ""
    else
      h_level (n - 1) ^ "#" in
  (h_level level) ^ " File: " ^ message.source_path

let uri_of_branch t =
  let uri_of_user user = "https://github.com/" ^ user in
  let uri_of_branch branch = "blob" ^ "/" ^ branch in
  (uri_of_user t.user ^ "/" ^ t.repo ^ "/" ^ (uri_of_branch t.branch))

let uri_of_message t ~msg =
  (uri_of_branch t) ^ "/" ^ (Message.uri_of msg ~root:t.root)

(** Review_comment.of_messages t messages *)
let of_messages t ~messages =
  let write_message msg =
    let buf = Buffer.create 1024 in
    Buffer.add_string buf msg.source_descr;
    Buffer.add_string buf "\n\n";
    Buffer.add_string buf (uri_of_message t ~msg);
    buf in
  let write ~buf ~msg = Buffer.add_buffer buf (write_message msg); buf in
  let write_with_crlf ~buf ~msg = Buffer.add_string (write ~buf ~msg) "\n\n"; buf in
  let write_messages ~buf ~messages =
    let rec write_messages ~buf ~messages =
      match messages with
        | [] -> buf
        | msg::[] -> write ~buf ~msg
        | msg::remain -> write_messages ~buf:(write_with_crlf ~buf ~msg:msg) ~messages:remain in
    write_messages ~buf ~messages in
  Buffer.contents (write_messages ~buf:(Buffer.create 1024) ~messages)

let of_error t ~error =
  let title_of messages = title_of_source (List.hd messages) in
  let content_of messages = of_messages t ~messages in
  (title_of error.error_messages) ^ "\n\n" ^ (content_of error.error_messages)

let create ?(root=Sys.getcwd ()) ~user ~repo ~branch ~json () =
  let t = init ~user ~repo ~branch ~root () in
  let add_title_to ~buf ~title = Buffer.add_string buf title; buf in
  let add_error_to ~buf ~error = (Buffer.add_string buf (of_error t error)); buf in
  let add_error_with_crlf_to ~buf ~error = (Buffer.add_string buf ((of_error t error) ^ "\n\n")); buf in
  let add_all_error_to ~buf ~errors =
    let rec add_all_error_to ~buf ~errors =
      match errors with
        | [] -> buf
        | [error] -> add_error_to ~buf ~error
        | error::remain_errors -> add_all_error_to ~buf:(add_error_with_crlf_to ~buf ~error) ~errors:remain_errors in
    add_all_error_to ~buf ~errors in
  let comment ~buf ~errors =
    add_all_error_to ~buf:(add_title_to ~buf ~title:"# Type checking errors\n\n") ~errors in
  (Buffer.contents (comment ~buf:(Buffer.create 1024) ~errors:json.errors)) ^ "\n"

let branch_for ~user ~repo ~branch = create ~user ~repo ~branch
