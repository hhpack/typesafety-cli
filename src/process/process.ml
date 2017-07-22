(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Lwt.Infix
open Lwt_process

module type S = sig
  val exec: ?ignore:bool -> Lwt_process.command -> (Process_result.t, Process_result.t) result Lwt.t
  val shell_exec: ?ignore:bool -> string -> (Process_result.t, Process_result.t) result Lwt.t
end

let rec read_line cp =
  if Lwt_io.is_busy cp#stdout then
    read_line cp
  else
    Lwt_io.read_line_opt cp#stdout

let read_stdout cp ~f =
  let rec try_read cp =
    let on_consumed = function
      | Some v -> f v; try_read cp
      | None -> Lwt.return_none in

    read_line cp >>= on_consumed in
  try_read cp

let exec ?(ignore=false) cmd =
  let buf = Buffer.create 1024 in
  let writeln s = Buffer.add_string buf s; Buffer.add_char buf '\n' in
  let cp = Lwt_process.open_process_in cmd ~stdin:`Close in

  let return status =
    let output = Buffer.contents buf in
    let result = Process_result.create ~status output in

    if ignore then
      Lwt.return_ok result
    else
      if Process_result.is_ok result then
        Lwt.return_ok result
      else
        Lwt.return_error result in

  let return_result status =
    let open Unix in
    match status with
      | WEXITED v -> return v
      | WSIGNALED v -> return v
      | WSTOPPED v -> return v in

  let rec wait_until_consumed cp =
    let on_consumed = function
      | None ->
        Lwt_io.close cp#stdout
          >>= (fun _ -> cp#status)
          >>= return_result
      | Some _ -> wait_until_consumed cp in
    match cp#state with
      | Running -> read_stdout cp ~f:writeln >>= on_consumed
      | Exited status -> return_result status in

  wait_until_consumed cp

let shell_exec ?(ignore=false) cmd =
  exec ~ignore (Lwt_process.shell cmd)
