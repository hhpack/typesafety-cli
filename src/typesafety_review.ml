open Cmdliner

let json_file =
  let doc = "Report file for input. (try hh_client check --json > output.json)" in
  Arg.(value & pos 0 string "JSON file path" & info [] ~docv:"JSON" ~doc)

let verbose =
  let doc = "If specified, will display detailed logs" in
  Arg.(value & flag & info ["verbose"] ~doc)

let review json_file verbose = Ok ()

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
