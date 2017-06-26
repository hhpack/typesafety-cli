(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Cmdliner

let json_file =
  let doc = "Report file for input. (try hh_client check --json > output.json)" in
  Arg.(required & pos 0 (some file) None & info [] ~docv:"JSON" ~doc)

let verbose =
  let doc = "If specified, will display detailed logs" in
  Arg.(value & flag & info ["verbose"] ~doc)

let review json_file verbose =
  let json = File.read_all json_file in
  let result_of json = Typechecker_check_j.result_of_string json in
  Log.set_verbose verbose;
  Log.info "Github review started\n";
  match Github_review.create (result_of json) with
    | Ok result ->
      begin
        let open Github_review in
        match result with
          | Skiped reason ->
            begin
              match reason with
                | NoError -> `Ok (Log.success "review skiped (no error)\n")
                | NotPullRequest -> `Ok (Log.success "review skiped (not pull request)\n")
            end
          | Reviewed _ -> `Ok (Log.success "review done\n")
      end
    | Error e -> `Error (false, e)

let review_t = Term.ret (Term.(const review $ json_file $ verbose))

let info =
  let doc = "Github review command" in
  let man = [ `S "BUGS"; `P "Email bug reports to <holy.shared.design@gmail.com>."; ] in
  Term.info "typesafety_github_review" ~version:"0.1.0" ~exits:Term.default_exits ~doc ~man

let () =
  Term.exit @@ (Term.eval (review_t, info))
