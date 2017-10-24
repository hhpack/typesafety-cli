(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

open Lwt.Infix

module type S = sig
  val exec: ?ignore:bool -> Lwt_process.command -> (Process_result.t, Process_result.t) result Lwt.t
  val shell_exec: ?ignore:bool -> string -> (Process_result.t, Process_result.t) result Lwt.t
end

let read_line ic =
  let rec inner_read_line ic =
    if Lwt_io.is_busy ic then
      inner_read_line ic
    else
    Lwt_io.read_line_opt ic in
  inner_read_line ic

let read_stdout ic ~f =
  let rec try_read ic =
    let on_consumed = function
      | Some v -> f v; try_read ic
      | None -> Lwt.return_none in

    read_line ic >>= on_consumed in
  try_read ic

let ignore_close ic = ignore (Lwt_io.close ic)

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
    let ic = cp#stdout in
    Gc.finalise ignore_close ic;
    let on_consumed = function
      | None ->
        Lwt_io.close ic
        >>= (fun _ -> cp#status)
        >>= return_result
      | Some _ -> wait_until_consumed cp in
    match cp#state with
      | Lwt_process.Running -> read_stdout ic ~f:writeln >>= on_consumed
      | Lwt_process.Exited status -> return_result status in

  wait_until_consumed cp

let shell_exec ?(ignore=false) cmd =
  exec ~ignore (Lwt_process.shell cmd)
