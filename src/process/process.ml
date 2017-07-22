open Lwt.Infix

type s =
  | ConsumeNext
  | EndOfStream of string

module type S = sig
  val exec: Lwt_process.command -> string Lwt.t
  val shell_exec: string -> string Lwt.t
end

let exec cmd =
  let buf = Buffer.create 1024 in
  let stream = Lwt_process.pread_lines cmd in

  let rec wait stream =
    let s = Lwt_stream.get stream in

    let buffer_and_next v =
      Buffer.add_string buf v; Lwt.return ConsumeNext in

    let on_consumed = function
      | Some v -> buffer_and_next v
      | None -> Lwt.return (EndOfStream (Buffer.contents buf)) in

    let end_or_next = function
      | EndOfStream v -> Lwt.return v
      | ConsumeNext -> wait stream in

    s >>= on_consumed >>= end_or_next in
  wait stream

let shell_exec cmd =
  exec (Lwt_process.shell cmd)
