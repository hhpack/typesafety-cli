open OUnit2
open Typesafety_reporter

let test_print_result =
  "print_result" >:: (
    fun _ ->
      let project_root_dir = Template.project_root_dir in
      let json = Template.read_template ~root:project_root_dir ~file:"../tests/fixtures/console.json" () in
      match Typesafety_reporter.print_json (Typechecker_check_j.result_of_string json) with
        | Ok _ -> assert_bool "always true" true
        | Error e -> assert_failure e
  )

let tests = "all_tests" >::: [ test_print_result; ]
