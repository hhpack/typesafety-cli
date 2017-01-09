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
  let created = FileCreated temp_config_file in
  unlink_config temp_config_file;
  match create_if_not_exists temp_dir with
    | Ok v -> assert_equal v created
    | Error e -> assert_failure e

let test_hhconfg_exists _ =
  let already_exists = AlreadyExists temp_config_file in
  let create_hhconfig () =
    if not (exists temp_config_file) then
      match touch temp_config_file with
        | Ok _ -> ()
        | Error e -> assert_failure e
    else
      () in
  create_hhconfig ();

  match create_if_not_exists temp_dir with
    | Ok v -> assert_equal v already_exists
    | Error e -> assert_failure e

let all_test_hhconfg =
  "create_hhconfg_if_not_exists" >::: [
    ("exists" >:: test_hhconfg_exists);
    ("not_exists" >:: test_hhconfg_not_exists);
  ]

let tests = "all_tests" >::: [
  all_test_hhconfg;
]
