open OUnit2
open Test_helper
open Typechecker_check_j

let test_create_review_comment _ =
  let open Github in
  let slug = Slug.of_string "holyshared/typesafety" in
  let branch = Branch.of_string "master" in
  let review_comment = Review_comment.branch_for ~slug ~branch in
  let expect = Template.read_template ~file:"../tests/fixtures/review_comment.md" () in
  let json = Template.json_from ~file:"../tests/fixtures/review_input.json" ~f:result_of_string () in
  let actual = review_comment json in
  assert_equal ~pp_diff:print_diff expect actual

let tests =
  "all_tests" >::: [
    ("create review comment" >:: test_create_review_comment);
  ]
