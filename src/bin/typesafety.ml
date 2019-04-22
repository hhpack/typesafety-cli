(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

open Cmdliner
open Misc.Log
open Cli
open Typechecker

let program_name = "typesafety"
let program_version = "0.14.1"

let print_if_typecheck_passed json ~msg =
  let open Typechecker_check_t in
  if json.passed then Ok (success msg) else Ok ()

let failed_if_typecheck_error json ~msg =
  let open Typechecker_check_t in
  if json.passed then Ok () else Error msg

let report_typecheck_result json ~review ~skip_passed =
  let reporters = [
    print_if_typecheck_passed ~msg:"There was no typecheck error\n";
    Typesafety_report.print_json;
    Typesafety_github.review_if ~review ~skip_passed;
    failed_if_typecheck_error ~msg:"There is an error of typecheck\n"
  ] in

  let rec report json ~reporters =
    match reporters with
      | [] -> Ok ()
      | reporter::remain_reporters ->
        match reporter json with
          | Ok _ -> report json ~reporters:remain_reporters
          | Error e -> Error e in

  report json ~reporters

let check no_hhconfig review skip_passed verbose =
  set_verbose verbose;
  info "\nType check is started\n\n";
  match Typesafety_check.typecheck ~no_hhconfig () with
    | Ok json ->
      begin
        match report_typecheck_result ~review ~skip_passed json with
          | Ok _ -> `Ok ()
          | Error e -> `Error (true, e)
      end
    | Error e -> `Error (true, e)

let no_hhconfig =
  let doc = "When hhconfig does not exist, do not generate files automatically" in
  Arg.(value & flag & info ["no-hhconfig"] ~doc)

let review =
  let doc = "If specified, post the type check result as a review comment." in
  Arg.(value & flag & info ["review"] ~doc)

let skip_passed =
  let doc = "If specified, do not post review comments when passing the type check" in
  Arg.(value & flag & info ["skip-passed"] ~doc)

let verbose =
  let doc = "If specified, will display detailed logs" in
  Arg.(value & flag & info ["verbose"] ~doc)

let check_t = Term.(ret Term.(const check $ no_hhconfig $ review $ skip_passed $ verbose))

let info =
  let doc = "Typechecker wrapper for Hack" in
  let man = [ `S "BUGS"; `P "Email bug reports to <holy.shared.design@gmail.com>."; ] in
  Term.info program_name ~version:program_version ~exits:Term.default_exits ~doc ~man

let () =
  Term.exit @@ (Term.eval (check_t, info))
