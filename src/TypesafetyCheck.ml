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
}

let check_hhvm_installed ctx =
  match HHVM.check_version () with
    | Ok v -> Ok (HHVM.parse_version v)
    | Error e -> Error e

let check_hhconfg ctx =
  HHConfig.create_if_not_exists (Sys.getcwd ())

let installed_version v =
  let open HHVM in
  match v with
    | Some v -> print_endline v.version
    | None -> print_string "oops!!"

let check_env ctx =
  match check_hhvm_installed ctx with
    | Ok v -> installed_version v; check_hhconfg ctx
    | Error e -> Error e

let typecheck ctx = 
  match check_env ctx with
    | Ok _ -> HHClient.typecheck_json ()
    | Error e -> Error e

let check no_hhconfig verbose =
  let ctx = {
    no_hhconfig=no_hhconfig;
    verbose=verbose
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
