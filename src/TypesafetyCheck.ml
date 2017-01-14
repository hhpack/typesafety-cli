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

let stdout_writer ctx =
  let print_message s = Ok (output_string ctx.stdout s) in
  verbose ctx.verbose print_message

let check_hhvm_installed ctx =
  let open HHVM in
  let write_stdout = stdout_writer ctx in
  let print_version v = write_stdout (Color.debug "Installed hhvm version: %s.\n" v.version) in
  let start = write_stdout (Color.debug "Checking the version of hhvm installed.\n") in  
  let check_version _ = HHVM.check_version () in
  let parse_version o = next o HHVM.parse_version in
  let print_installed_version o = next o print_version in
  start |> check_version |> parse_version |> print_installed_version

let check_hhconfg ctx =
  let config_file = HHConfig.config_path () in
  let exists = HHConfig.exists config_file in
  let not_exists_error = Error (config_file ^ " is not found") in
  HHConfig.create_if (not exists) not_exists_error

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
