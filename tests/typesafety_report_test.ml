open OUnit2
open Cli
open Typechecker

let test_print_result =
  "print_result" >:: (
    fun _ ->
      let json = Template.read_template ~file:"fixtures/console.json" () in
      match Typesafety_report.print_json (Typechecker_check_j.result_of_string json) with
        | Ok _ -> assert_bool "always true" true
        | Error e -> assert_failure e
  )

let tests = "all_tests" >::: [ test_print_result; ]
