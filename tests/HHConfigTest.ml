open OUnit2
open HHConfig

let temp_dir = Filename.get_temp_dir_name ()
let temp_config_file = (File.dirname temp_dir) ^ "/" ^ ".hhconfig"

let unlink_config file =
  if Sys.file_exists file then
    try
      Sys.remove file
    with Sys_error _ -> ()
  else
    ()

let test_hhconfg_not_exists _ =
  let _ = unlink_config temp_config_file in
  let created = FileCreated temp_config_file in
  let not_exists = not (exists temp_config_file) in
  let exists_error = Error "already exists" in

  match create_if ~dir:temp_dir not_exists exists_error with
    | Ok v -> assert_equal v created
    | Error e -> assert_failure e

let test_hhconfg_exists _ =
  let _ =
    if not (exists temp_config_file) then
      match touch temp_config_file with
        | Ok _ -> ()
        | Error e -> assert_failure e
    else
      () in
  let already_exists = AlreadyExists temp_config_file in
  let not_exists = not (exists temp_config_file) in

  match create_if not_exists (Ok already_exists) with
    | Ok v -> assert_equal v already_exists
    | Error e -> assert_failure e

let test_auto_generate _ =
  let _ = unlink_config temp_config_file in
  let created = FileCreated temp_config_file in
  match create_if_auto_generate ~dir:temp_dir false with
    | Ok v -> assert_equal v created
    | Error e -> assert_failure e

let all_test_hhconfg =
  "create_if" >::: [
    ("exists" >:: test_hhconfg_exists);
    ("not_exists" >:: test_hhconfg_not_exists);
  ]

let tests = "all_tests" >::: [
  all_test_hhconfg;
  ("test_auto_generate" >:: test_auto_generate);
]
