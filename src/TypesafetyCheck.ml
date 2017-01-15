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

let next_with_result o f =
  match o with
    | Ok v -> f v
    | Error e -> Error e

let next_with_context o ctx f =
  match o with
    | Ok _ -> f ctx
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
  let parse_version o = next_with_result o HHVM.parse_version in
  let print_installed_version o = next_with_result o print_version in
  start |> check_version |> parse_version |> print_installed_version

let check_hhconfg ctx =
  let write_stdout = stdout_writer ctx in
  let auto_config_generate _ = HHConfig.create_if_auto_generate ctx.no_hhconfig in
  let start = write_stdout (Color.debug "Checking configuration file.\n") in
  let generated o =
    match o with
      | Ok v -> write_stdout (Color.debug "%s\n" (HHConfig.string_of_result v))
      | Error e -> Error e in
  start |> auto_config_generate |> generated

let typecheck ctx = 
  let check_hhvm_installed = check_hhvm_installed ctx in
  let check_hhconfg o = next_with_context o ctx check_hhconfg in
  let typecheck_json _ = HHClient.typecheck_json () in
  let typecheck o = next_with_context o ctx typecheck_json in
  check_hhvm_installed |> check_hhconfg |> typecheck

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
