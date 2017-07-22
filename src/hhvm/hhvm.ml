(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Log

module type S = sig
  val check_version: unit -> (string, string) result Lwt.t
  val parse_version: string -> (Hhvm_version.t, string) result
  val print_version: Hhvm_version.t -> unit
end

module Make(S: Process.S) : S  = struct
  open Lwt.Infix

  include Hhvm_version

  let return_result ~msg result =
    match result with
      | Ok v -> Process_result.return_ok v
      | Error err -> Process_result.return_error ~msg err

  let check_version () =
    let command = ("", [|"hhvm"; "--version"|]) in
    S.exec command >>= return_result ~msg:"hhvm not installed"
end
