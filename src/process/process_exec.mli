(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

module type S = sig
  val exec: ?ignore:bool -> Lwt_process.command -> (Process_result.t, Process_result.t) result Lwt.t
  val shell_exec: ?ignore:bool -> string -> (Process_result.t, Process_result.t) result Lwt.t
end

val exec: ?ignore:bool -> Lwt_process.command -> (Process_result.t, Process_result.t) result Lwt.t
val shell_exec: ?ignore:bool -> string -> (Process_result.t, Process_result.t) result Lwt.t
