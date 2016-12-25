open Cmdliner

let check () =
  Typesafety_reporter.print_result_file "output.json"

let check_t = Term.(const check)

let info =
  let doc = "Typechecker wrapper for Hack" in
  let man = [ `S "BUGS"; `P "Email bug reports to <holy.shared.design@gmail.com>."; ] in
  Term.info "typesafety" ~version:"0.1.0" ~doc ~man

let program_terminate = function
  | `Error _ -> exit 1
  | _ -> exit 0

let () =
  program_terminate (Term.eval (check_t, info))
