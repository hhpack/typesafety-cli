open Cmdliner

let check_hhvm_installed () =
  match HHVMVersion.check_hhvm_version () with
    | Ok v -> Ok (HHVMVersion.parse_hhvm_version v)
    | Error e -> Error e

let check_hhconfg () =
  HHConfig.create_hhconfg_if_not_exists (Sys.getcwd ())

let check_env () =
  match check_hhvm_installed () with
    | Ok _ -> check_hhconfg ()
    | Error e -> Error e

let check no_hhconfig =
  match check_env () with
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
