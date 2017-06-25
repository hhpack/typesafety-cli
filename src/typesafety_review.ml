open Cmdliner

let json_file =
  let doc = "Report file for input. (try hh_client check --json > output.json)" in
  Arg.(value & pos 0 string "JSON file path" & info [] ~docv:"JSON" ~doc)

let verbose =
  let doc = "If specified, will display detailed logs" in
  Arg.(value & flag & info ["verbose"] ~doc)

let review json_file verbose =
  if Sys.file_exists json_file then
    begin
      let json = File.read_all json_file in
      let result_of json = Typechecker_check_j.result_of_string json in
      match Github_review.create (result_of json) with
        | Ok result -> begin
          let open Github_review in
          match result with
            | Skiped reason ->
              begin
                match reason with
                  | NoError -> Ok (Log.success "review skiped (no error)\n")
                  | NotPullRequest -> Ok (Log.success "review skiped (not pull request)\n")
              end
            | Reviewed _ -> Ok (Log.success "review done\n")
          end
        | Error e -> Error e
    end
  else
    Error ("File " ^ json_file ^ " not found")

let review_t = Term.(const review $ json_file $ verbose)

let info =
  let doc = "Github review command" in
  let man = [ `S "BUGS"; `P "Email bug reports to <holy.shared.design@gmail.com>."; ] in
  Term.info "typesafety_github_review" ~version:"0.1.0" ~doc ~man

let program_terminate = function
  | `Error _ -> exit 1
  | _ -> exit 0

let () =
  program_terminate (Term.eval (review_t, info))
