(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
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
  module Review = Github_review.Make(Ci_detector)(Http_client)

  type result =
    | Skiped of string
    | Reviewed of Github_t.review_result
    | ReviewFailed of string

  let skiped_reason = function
    | Github_review.NoError -> Skiped "Skiped github review (reason: no errors)"
    | Github_review.NotPullRequest -> Skiped "Skiped github review (reason: not pull request)"

  let review_success result =
    let open Github_t in
    match result with
      | Github_review.Reviewed json -> Reviewed json
      | Github_review.Skiped v -> skiped_reason v

  let on_review result =
    let open Github_t in
    match result with
      | Skiped v -> Ok (info "%s\n" v)
      | Reviewed json -> Ok (info "The review was successful\n%s" json.pull_request_url)
      | ReviewFailed e -> Error e

  let create_review json =
    match Review.create json with
      | Ok v -> review_success v
      | Error e -> ReviewFailed e

  let skip_review json = Skiped "Skiped github review"

  let review_if json ~review =
    let try_review json =
      if review then
        create_review json
      else
        skip_review json in
    try_review json |> on_review
end

let print_if_typecheck_passed json ~msg =
  let open Typechecker_check_t in
  if json.passed then Ok (success msg) else Ok ()

let failed_if_typecheck_error json ~msg =
  let open Typechecker_check_t in
  if json.passed then Ok () else Error msg

let report_typecheck_result json ~review =
  let reporters = [
    print_if_typecheck_passed ~msg:"There was no typecheck error\n";
    Report_task.print_json;
    Github_task.review_if ~review;
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

let check no_hhconfig review verbose =
  let ctx = {
    no_hhconfig=no_hhconfig;
    review=review;
    verbose=verbose;
  } in
  set_verbose verbose;
  info "Type check is started\n";
  match typecheck ctx with
    | Ok json ->
      begin
        match report_typecheck_result ~review json with
          | Ok _ -> `Ok ()
          | Error e -> `Error (true, e)
      end
    | Error e -> `Error (true, e)

let no_hhconfig =
  let doc = "When hhconfig does not exist, do not generate files automatically" in
  Arg.(value & flag & info ["no-hhconfig"] ~doc)

let review =
  let doc = "If specified, will leave a review comment by Github" in
  Arg.(value & flag & info ["review"] ~doc)

let verbose =
  let doc = "If specified, will display detailed logs" in
  Arg.(value & flag & info ["verbose"] ~doc)

let check_t = Term.(ret Term.(const check $ no_hhconfig $ review $ verbose))

let info =
  let doc = "Typechecker wrapper for Hack" in
  let man = [ `S "BUGS"; `P "Email bug reports to <holy.shared.design@gmail.com>."; ] in
  Term.info "typesafety" ~version:"0.1.0" ~exits:Term.default_exits ~doc ~man
