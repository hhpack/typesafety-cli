open OUnit2

let () =
  run_test_tt_main ("all_tests" >::: [
    Hh_config_test.tests;
    Hhvm_test.tests;
    Typesafety_reporter_test.tests;
    Source_file_test.tests;
    Lines_test.tests;
    Review_comment_test.tests
  ])
