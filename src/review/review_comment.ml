(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Hack
open Typechecker.Typechecker_check_t

module Message = struct
  type t = error_detail

  let path_from ?(root=Sys.getcwd ()) t =
    Str.replace_first (Str.regexp (root ^ "/")) "" t.source_path

  let uri_of ?(root=Sys.getcwd ()) t =
    (path_from t ~root) ^ "#L" ^ (string_of_int t.source_line)
end

module Context = struct
  type t = {
    user: Github.User.t;
    repo: Github.Repository.t;
    branch: Github.Branch.t;
    root: string;
  }

  let create ?(root=Sys.getcwd ()) ~slug ~branch () =
    let user = Github.Slug.repo_owner slug in
    let repo = Github.Slug.repo_name slug in
    { user; repo; branch; root }

  let uri_of_user t = "https://github.com/" ^ (Github.User.to_string t.user)
  let uri_of_branch t = Printf.sprintf "%s/%s" "blob" (Github.Branch.to_string t.branch)
  let uri_of_repository t = (Github.Repository.to_string t.repo)

  let url_of_branch t =
    Printf.sprintf "%s/%s/%s" (uri_of_user t) (uri_of_repository t) (uri_of_branch t)

  let url_of_message t ~msg =
    (url_of_branch t) ^ "/" ^ (Message.uri_of msg ~root:t.root)

  let relative_from t ~path =
    Str.replace_first (Str.regexp (t.root ^ "/")) "" path
end

module Passed_comment = struct
  let add_title buf ~s =
    Comment_buffer.writeln buf ~s

  let create t ~json =
    Comment_buffer.(
      create ()
      |> add_title ~s:":tada: There was no type error in your pull request."
      |> contents
    )
end

module Failed_comment = struct
  let title_of_source t ~buf ~msg =
    Comment_buffer.(
      write buf ~s:"* [ ] " |>
      write_wrap_s ~wrap:"**" ~s:(Context.relative_from t ~path:msg.source_path)
    )

  let hint_of_message t ~msg =
    let scol = msg.source_start in
    let ecol = msg.source_end in
    Comment_buffer.(
      t |>
      write_space ~n:(scol - 1) |>
      write_ntimes ~c:'^' ~n:(ecol - scol + 1) |>
      writeln
    )

  let source_of_message ~msg buf =
    let hack_code_start buf = Comment_buffer.write_with_indent ~ln:1 ~s:"```hack" buf in
    let hack_code_end buf = Comment_buffer.write_with_indent ~ln:1 ~s:"```" buf in
    let write_line ~llen ~line buf =
      let line_number, line_source = line in
      let indent = llen - (StringLabels.length (string_of_int line_number)) in
      Comment_buffer.(
        write_with_indent buf ~s:(spaces ~n:indent) |>
        writeln ~s:((string_of_int line_number) ^ ":" ^ line_source)
      ) in
    let write_lines_of ~msg buf =
      let rec max_line_length ?(max=0) lines =
        match lines with
          | [] -> max
          | hd::tail ->
            let l, _ = hd in
            let line_number_length = StringLabels.length (string_of_int l) in
            max_line_length ~max:(Pervasives.max line_number_length max) tail in
      let lines = Source_file.read_range ~line:msg.source_line msg.source_path in
      let line_length = max_line_length lines in
      let write_if_error_line ~line buf =
        let line_num, _ = line in
        if msg.source_line = line_num then
          let current_line_len = (StringLabels.length (string_of_int line_num)) in
          let indent = (line_length - current_line_len) + current_line_len + 1 in
          Comment_buffer.(
            write_indent buf |>
            write_space ~n:indent |>
            hint_of_message ~msg
          )
        else
          buf in
      let write_line_of buf line =
        write_line ~line:line ~llen:line_length buf |>
        write_if_error_line ~line:line in
      ListLabels.fold_left ~f:write_line_of ~init:buf lines in

    Comment_buffer.(
      hack_code_start buf |>
      write_lines_of ~msg |>
      hack_code_end
    )

  let comment_of_messages t ~buf ~messages =
    let write_message buf ~msg =
      Comment_buffer.(
        write_with_indent buf ~s:msg.source_descr ~ln:2 |>
        source_of_message ~msg |>
        writeln |>
        write_with_indent ~s:(Context.url_of_message t ~msg)
      ) in
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
      title_of_source t ~buf ~msg:(ListLabels.hd error.error_messages) |>
      Comment_buffer.writeln ~n:2 in
    let content_of buf ~error =
      comment_of_messages t ~buf ~messages:error.error_messages in
    title_of buf ~error |> content_of ~error

  let create t ~json =
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
      add_all buf ~errors
        |> Comment_buffer.writeln in

    Comment_buffer.(
      create () |>
      add_title ~s:"Type check error found in your pull request." |>
      add_all_error ~errors:json.errors |>
      contents
    )
end

let create ?(root=Sys.getcwd ()) ~slug ~branch json =
  let comment_by =
    if json.passed then
      Passed_comment.create ~json
    else
      Failed_comment.create ~json in
  comment_by (Context.create ~slug ~branch ~root ())
