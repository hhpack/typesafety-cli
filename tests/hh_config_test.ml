open OUnit2
open Hh_config

let failed e ~prefix =
  Error (prefix ^ e)

let unlink_config f =
  if not (Sys.file_exists f) then
    Ok (Printf.printf "not found: %s\n" f)
  else
    try
      Sys.remove f;
      Ok (Printf.printf "unlink: %s\n" f)
    with Sys_error e ->
      Ok (Printf.printf "Sys_error: %s\n" e)

let touch_config f =
  let to_result v =
    Ok (Printf.printf "touch_config: %s\n" (string_of_result v)) in
  let touch_temp_config f = match touch f with
    | Ok v -> to_result v
    | Error e -> failed ~prefix:"touch_temp_config: " e in
  match unlink_config f with
    | Ok _ -> touch_temp_config f
    | Error e -> failed ~prefix:"unlink_config: " e

let test_auto_generate_exists ctx =
  let temp_dir = bracket_tmpdir ctx in
  let temp_file = (Filename.concat temp_dir ".hhconfig") in
  match touch_config temp_file with
    | Error e -> assert_failure e
    | Ok _ ->
      let already_exists = AlreadyExists temp_file in
      match create_if ~dir:temp_dir ~no_hhconfig:true () with
        | Ok v -> assert_equal ~msg:"when exists" already_exists v
        | Error e -> assert_failure e

let test_auto_generate_not_exists ctx =
  let temp_dir = bracket_tmpdir ctx in
  let temp_file = (Filename.concat temp_dir ".hhconfig") in
  let created = FileCreated temp_file in
  match create_if ~dir:temp_dir ~no_hhconfig:false () with
    | Ok v -> assert_equal ~msg:"when not_exists" created v
    | Error e -> assert_failure e

let tests = "all_tests" >::: [
  "create_if" >::: [
    ("exists && no_hhconfig = true" >:: test_auto_generate_exists);
    ("not_exists && no_hhconfig = false" >:: test_auto_generate_not_exists);
  ]
]
