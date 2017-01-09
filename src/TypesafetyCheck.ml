(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Cmdliner

type context = {
  no_hhconfig: bool;
  verbose: bool;
  stdout: out_channel;
  stderr: out_channel;
}

let next o f =
  match o with
    | Ok v -> f v
    | Error e -> Error e

let noop v = Ok ()

let verbose v f =
  if v then f else noop

let version_printer ctx =
  let print_version v = Ok (HHVM.print_version ctx.stdout v) in
  verbose ctx.verbose print_version

let start_message_printer ctx =
  let start_message _ = Ok (output_string ctx.stdout (Color.debug "Checking the version of hhvm installed.")) in
  verbose ctx.verbose start_message

let check_hhvm_installed ctx =
  let version_printer = version_printer ctx in
  let start = start_message_printer ctx in  

  (* let start = Ok (print_endline (Color.debug "Checking the version of hhvm installed.")) in *)
  let check_version _ = HHVM.check_version () in
  let parse_version o = next o HHVM.parse_version in
  let print_installed_version o = next o version_printer in
  start |> check_version |> parse_version |> print_installed_version

let check_hhconfg ctx =
  HHConfig.create_if_not_exists (Sys.getcwd ())

let check_env ctx =
  match check_hhvm_installed ctx with
    | Ok _ -> check_hhconfg ctx
    | Error e -> Error e

let typecheck ctx = 
  match check_env ctx with
    | Ok _ -> HHClient.typecheck_json ()
    | Error e -> Error e

let check no_hhconfig verbose =
  let ctx = {
    no_hhconfig=no_hhconfig;
    verbose=verbose;
    stdout=stdout;
    stderr=stderr;
  } in
  match typecheck ctx with
    | Ok v -> TypesafetyReporter.print_json v; Ok ()
    | Error e -> Error e

let no_hhconfig =
  let doc = "When hhconfig does not exist, do not generate files automatically" in
  Arg.(value & flag & info ["no-hhconfig"] ~doc)

let verbose =
  let doc = "If specified, will display detailed logs" in
  Arg.(value & flag & info ["verbose"] ~doc)

let check_t = Term.(const check $ no_hhconfig $ verbose)

let info =
  let doc = "Typechecker wrapper for Hack" in
  let man = [ `S "BUGS"; `P "Email bug reports to <holy.shared.design@gmail.com>."; ] in
  Term.info "typesafety" ~version:"0.1.0" ~doc ~man
