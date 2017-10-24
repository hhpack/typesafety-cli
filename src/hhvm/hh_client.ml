(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

open Lwt.Infix
open Misc.Log
open Typechecker
open Process

module type S = sig
  val typecheck_json: unit -> (Typechecker_check_t.result, string) result Lwt.t
end

module Make(S: Process_exec.S): S = struct
  let with_redirect cmd =
    Printf.sprintf "hh_client %s 2>&1" cmd

  let verbose = function
    | Ok v -> debug "[hh_client]: %s\n" v; Lwt.return_ok v
    | Error e -> Lwt.return_error e

  let return_result ~msg result =
    match result with
      | Ok v -> Process_result.return_ok v
      | Error err -> Process_result.return_error ~msg err

  let restart () =
    S.shell_exec (with_redirect "restart")
    >>= return_result ~msg:"Server restart failed"

  let check () =
    S.shell_exec ~ignore:true (with_redirect "check --json")
    >>= return_result ~msg:"Did not return the expected json results"

  let to_json result =
    match result with
      | Ok s -> Lwt.return_ok (Typechecker_check_j.result_of_string s)
      | Error e -> Lwt.return_error e

  let next result ~f =
    match result with
      | Ok _ -> f ()
      | Error e -> Lwt.return_error e

  let typecheck_json () =
    restart ()
    >>= verbose
    >>= next ~f:check
    >>= verbose
    >>= to_json
end
