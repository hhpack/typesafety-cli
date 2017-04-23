open Typechecker_check_t

module Comment_buffer = struct
  type t = Buffer.t

  let create ?(size=1024) () =
    Buffer.create size

  let write t ~s =
    Buffer.add_string t s; t

  let write_ntimes t ~s ~n =
    let rec add_s t ~s ~n =
      if n > 0 then
        (write t ~s) |> add_s ~s ~n:(n - 1)
      else
        t in
    add_s t ~s ~n

  let writeln ?s ?(n=1) t =
    match s with
      | Some s -> (write t s) |> write_ntimes ~s:"\n" ~n
      | None -> write_ntimes t ~s:"\n" ~n

  let contents t =
    Buffer.contents t
end

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

let title_of_source ?(level = 2) ~buf ~msg () =
  Comment_buffer.write_ntimes buf ~s:"#" ~n:level |>
  Comment_buffer.write ~s:" File: " |>
  Comment_buffer.write ~s:msg.source_path

let uri_of_branch t =
  let uri_of_user user = "https://github.com/" ^ user in
  let uri_of_branch branch = "blob" ^ "/" ^ branch in
  (uri_of_user t.user ^ "/" ^ t.repo ^ "/" ^ (uri_of_branch t.branch))

let uri_of_message t ~msg =
  (uri_of_branch t) ^ "/" ^ (Message.uri_of msg ~root:t.root)

let hint_of_message t ~msg =
  let scol = msg.source_start in
  let ecol = msg.source_end in
  Comment_buffer.(
    t |>
    write_ntimes ~s:" " ~n:(scol - 1) |>
    write_ntimes ~s:"^" ~n:(ecol - scol + 1)
  )

let source_of_message ~msg =
  let quotation buf = Comment_buffer.writeln ~s:"```" buf in
  let lines_of f = Source_file.read_range ~line:msg.source_line f in
  let write_line line buf =
    let line_number, line_source = line in
    Comment_buffer.write buf ((string_of_int line_number) ^ ":" ^ line_source) in
  let write_lines_of ~msg buf = List.fold_right write_line (lines_of msg.source_path) buf in

  Comment_buffer.create () |>
  quotation |>
  write_lines_of ~msg |>
  quotation |>
  Comment_buffer.contents

let comment_of_messages t ~buf ~messages =
  let write_message buf ~msg =
    Comment_buffer.writeln buf ~s:msg.source_descr ~n:2 |>
    Comment_buffer.write ~s:(uri_of_message t ~msg) in
  let write ~buf ~msg = write_message buf ~msg in
  let write_with_crlf ~buf ~msg =
    (write ~buf ~msg) |> Comment_buffer.writeln ~n:2 in
  let write_messages ~buf ~messages =
    let rec write_messages ~buf ~messages =
      match messages with
        | [] -> buf
        | msg::[] -> write ~buf ~msg
        | msg::remain -> write_messages ~buf:(write_with_crlf ~buf ~msg:msg) ~messages:remain in
    write_messages ~buf ~messages in
  write_messages ~buf ~messages

let comment_of_error t ~buf ~error =
  let title_of buf ~error =
    title_of_source ~buf ~msg:(List.hd error.error_messages) () |>
    Comment_buffer.writeln ~n:2 in
  let content_of buf ~error =
    comment_of_messages t ~buf ~messages:error.error_messages in
  title_of buf ~error |> content_of ~error

let create ?(root=Sys.getcwd ()) ~user ~repo ~branch ~json () =
  let t = init ~user ~repo ~branch ~root () in
  let add_title buf ~s =
    Comment_buffer.writeln buf ~s ~n:2 in
  let add_error buf ~error =
    comment_of_error t ~buf ~error in
  let add_error_with_crlf buf ~error =
    comment_of_error t ~buf ~error |> Comment_buffer.writeln ~n:2 in
  let add_all_error buf ~errors =
    let rec add_all buf ~errors =
      match errors with
        | [] -> buf
        | [error] -> add_error buf ~error
        | error::remain_errors ->
          add_error_with_crlf buf ~error |>
          add_all ~errors:remain_errors in
    add_all buf ~errors |>
    Comment_buffer.writeln in

    Comment_buffer.create () |>
    add_title ~s:"# Type checking errors" |>
    add_all_error ~errors:json.errors |>
    Comment_buffer.contents

let branch_for ~user ~repo ~branch = create ~user ~repo ~branch
