open OUnit2

let () =
  run_test_tt_main ("all_tests" >::: [
    Hh_config_test.tests;
    Hhvm_test.tests;
    Typesafety_report_test.tests;
    Source_file_test.tests;
    Source_lines_test.tests;
    Review_comment_test.tests;
    Travis_test.tests;
    General_test.tests;
    Github_j_test.tests
  ])
