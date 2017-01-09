open Cmdliner

let check_hhvm_installed () =
  match HHVM.check_version () with
    | Ok v -> Ok (HHVM.parse_version v)
    | Error e -> Error e

let check_hhconfg () =
  HHConfig.create_if_not_exists (Sys.getcwd ())

let installed_version v =
  let open HHVM in
  match v with
    | Some v -> print_endline v.version
    | None -> print_string "oops!!"

let check_env () =
  match check_hhvm_installed () with
    | Ok v -> installed_version v; check_hhconfg ()
    | Error e -> Error e

let typecheck () = 
  match check_env () with
    | Ok _ -> HHClient.typecheck_json ()
    | Error e -> Error e

let check no_hhconfig =
  match typecheck () with
    | Ok v -> TypesafetyReporter.print_json v; Ok ()
    | Error e -> Error e

let no_hhconfig =
  let doc = "When hhconfig does not exist, do not generate files automatically" in
  Arg.(value & flag & info ["no-hhconfig"] ~doc)

let check_t = Term.(const check $ no_hhconfig)

let info =
  let doc = "Typechecker wrapper for Hack" in
  let man = [ `S "BUGS"; `P "Email bug reports to <holy.shared.design@gmail.com>."; ] in
  Term.info "typesafety" ~version:"0.1.0" ~doc ~man
