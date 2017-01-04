open Process
open Process.Exit
open Process.Output

let hhclient_command cmd = run "hh_client" [|cmd|]
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
  let result = hhclient_command "check" in
  match result.exit_status with
    | Exit _ -> Ok (hhclient_stderr result)
    | Kill signal -> Error (hhclient_error signal result)
    | Stop signal -> Error (hhclient_error signal result)

let restart_with_check () =
  match restart () with
    | Ok v ->
      print_string v;
      check ()
    | Error e -> Error e

let typecheck_json () =
  match restart_with_check () with
    | Ok v -> Ok v
    | Error e -> Error e
