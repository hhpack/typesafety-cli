(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Process
open Process.Exit
open Process.Output
open Log

let hhclient_command ?(args=[||]) cmd =
  let exec_args = Array.append [|cmd|] args in
  run "hh_client" exec_args

let hhclient_stderr result = String.concat "\n" result.stderr

let hhclient_error signal result =
  let signal_string = Signal.to_string signal in
  let stderr_output = hhclient_stderr result in
  signal_string ^ ": " ^ stderr_output

let restart () =
  let result = hhclient_command "restart" in
  match result.exit_status with
    | Exit _ -> Ok (hhclient_stderr result)
    | Kill signal -> Error (hhclient_error signal result)
    | Stop signal -> Error (hhclient_error signal result)

let check () =
  let result = hhclient_command "check" ~args:[|"--json"|]in
  match result.exit_status with
    | Exit _ -> Ok (hhclient_stderr result)
    | Kill signal -> Error (hhclient_error signal result)
    | Stop signal -> Error (hhclient_error signal result)

let typecheck = function
  | Ok _ -> check ()
  | Error e -> Error e

let to_json o =
  match o with
    | Ok s -> Ok (Typechecker_check_j.result_of_string s)
    | Error e -> Error e

let verbose = function
  | Ok v -> debug "[hh_client]: %s" v; Ok v
  | Error e -> Error e

let typecheck_json () =
  restart ()
    |> verbose
    |> typecheck
    |> verbose
    |> to_json
