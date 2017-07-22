module type S = sig
  val exec: Lwt_process.command -> string Lwt.t
  val shell_exec: string -> string Lwt.t
end

val exec: Lwt_process.command -> string Lwt.t
