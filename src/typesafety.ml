open Cmdliner

let check () =
  Typesafety_reporter.print_result_file "output.json"

let check_t = Term.(const check)

let info =
  let doc = "document message" in
  let man = [ `S "BUGS"; `P "Email bug reports to <hehey at example.org>."; ] in
  Term.info "typesafety" ~version:"0.1.0" ~doc ~man

let program_terminate = function
  | `Error _ -> exit 1
  | _ -> exit 0

let () =
  program_terminate (Term.eval (check_t, info))
