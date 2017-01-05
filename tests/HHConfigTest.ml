open OUnit2
open HHConfig

let temp_dir = Filename.get_temp_dir_name ()
let temp_config_file = (File.dirname temp_dir) ^ "/" ^ ".hhconfig"

let unlink_config dir =
  try
    Sys.remove ((File.dirname dir) ^ "/" ^ config_file)
  with Sys_error _ -> ()

let assert_hhconfg =
  match create_hhconfg_if_not_exists temp_dir with
    | Ok v -> assert_equal v temp_config_file
    | Error e -> assert_failure e

let test_hhconfg_not_exists _ =
  unlink_config temp_dir;
  if hhconfg_exists temp_dir then assert_failure "File prerequisite is invalid";

  match create_hhconfg_if_not_exists temp_dir with
    | Ok v -> assert_equal v temp_config_file
    | Error e -> assert_failure e

let test_hhconfg_exists _ =
  if hhconfg_exists temp_dir then unlink_config temp_dir;
  match touch_hhconfig temp_dir with
    | Ok v -> assert_hhconfg
    | Error e -> assert_failure e

let all_test_hhconfg =
  "create_hhconfg_if_not_exists" >::: [
    ("exists" >:: test_hhconfg_exists);
    ("not_exists" >:: test_hhconfg_not_exists);
  ]

let tests = "all_tests" >::: [
  all_test_hhconfg;
]
