(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Cmdliner
open Log

type context = {
  no_hhconfig: bool;
  review: bool;
  verbose: bool;
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

let check_hhvm_installed ctx =
  let open Hhvm in
  let print_version v = Ok (debug "Installed hhvm version: %s.\n" v.version) in
  let start = Ok (debug "Checking the version of hhvm installed.\n") in
  let check_version _ = Hhvm.check_version () in
  let parse_version o = next_with_result o Hhvm.parse_version in
  let print_installed_version o = next_with_result o print_version in
  start |> check_version |> parse_version |> print_installed_version

let check_hhconfg ctx =
  let auto_config_generate o =
    match o with
      | Ok _ -> Hh_config.create_if ~no_hhconfig:ctx.no_hhconfig ()
      | Error e -> Error e in
  let start = Ok (debug "Checking configuration file.\n") in
  let generated o =
    match o with
      | Ok v -> Ok (debug "%s\n" (Hh_config.string_of_result v))
      | Error e -> Error e in
  start |> auto_config_generate |> generated

let typecheck ctx =
  let check_hhvm_installed = check_hhvm_installed ctx in
  let check_hhconfg o = next_with_context o ctx check_hhconfg in
  let typecheck_json _ = Hh_client.typecheck_json () in
  let typecheck o = next_with_context o ctx typecheck_json in
  check_hhvm_installed |> check_hhconfg |> typecheck

module Report_task = struct
  let print_json json = Typesafety_reporter.print_json json
end

module Github_task = struct
  let review_success result =
    let open Github_t in
    match result with
      | Github_review.Reviewed json -> Ok (info "The review was successful\n%s" json.pull_request_url)
      | Github_review.Skiped _ -> Ok (info "%s" "Skiped github review")

  let on_review = function
    | Ok v -> review_success v
    | Error e -> Error e

  let create_review json = Github_review.create json

  let skip_review json = Ok (Github_review.Skiped ())

  let review_if json ~review =
    let try_review json =
      if review then
        create_review json
      else
        skip_review json in
    try_review json |> on_review
end

let check no_hhconfig review verbose =
  let ctx = {
    no_hhconfig=no_hhconfig;
    review=review;
    verbose=verbose;
  } in
  set_verbose verbose;
  match typecheck ctx with
    | Ok json -> Report_task.print_json json; Github_task.review_if ~review json
    | Error e -> Error e

let no_hhconfig =
  let doc = "When hhconfig does not exist, do not generate files automatically" in
  Arg.(value & flag & info ["no-hhconfig"] ~doc)

let review =
  let doc = "If specified, will leave a review comment by Github" in
  Arg.(value & flag & info ["review"] ~doc)

let verbose =
  let doc = "If specified, will display detailed logs" in
  Arg.(value & flag & info ["verbose"] ~doc)

let check_t = Term.(const check $ no_hhconfig $ review $ verbose)

let info =
  let doc = "Typechecker wrapper for Hack" in
  let man = [ `S "BUGS"; `P "Email bug reports to <holy.shared.design@gmail.com>."; ] in
  Term.info "typesafety" ~version:"0.1.0" ~doc ~man
