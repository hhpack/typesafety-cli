open OUnit2
open TypesafetyMiddleware

let test_parse_hhvm_version =
  "parse_hhvm_version" >:: (
    fun _ ->
      let open HHVMVersion in
      let hhvm_version = "HipHop VM 3.17.0 (rel)\n" in
      let hhvm_compiler = "Compiler: tags/HHVM-3.17.0-0-ga34af693b558ed98ffafc3f5127e00959e145e4f\n" in
      let hhvm_repo_schema = "Repo schema: 8eda451fe80742a18e0e2e8917aa4053c2c1afe7\n" in
      let hhvm_version_output = hhvm_version ^ hhvm_compiler ^ hhvm_repo_schema in
      let result = match parse_hhvm_version hhvm_version_output with
        | Some v -> v
        | None -> { version=""; compiler=""; repo_schema=""; } in

      assert_equal result.version "3.17.0 (rel)";
      assert_equal result.compiler "tags/HHVM-3.17.0-0-ga34af693b558ed98ffafc3f5127e00959e145e4f";
      assert_equal result.repo_schema "8eda451fe80742a18e0e2e8917aa4053c2c1afe7";
    )

module HHConfigTest = struct
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
end

let tests = "all_tests" >::: [
  test_parse_hhvm_version;
  HHConfigTest.all_test_hhconfg;
]
