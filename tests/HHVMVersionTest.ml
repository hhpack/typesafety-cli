open OUnit2
open HHVMVersion

let test_parse_hhvm_version =
  "parse_hhvm_version" >:: (
    fun _ ->
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

let tests = "all_tests" >::: [
  test_parse_hhvm_version;
]
