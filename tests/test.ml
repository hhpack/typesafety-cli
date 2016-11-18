open OUnit2

let () =
  run_test_tt_main ("all_tests" >::: [
    Typesafety_reporter_test.tests;
    Source_file_test.tests
  ])
