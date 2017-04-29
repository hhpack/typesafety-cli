open Test_helper
open Typechecker_check_j

let user = "holyshared"
let repo = "typesafety"
let branch = "master"

let init () = Review_comment.init ~user ~repo ~branch ()

let error_detail = {
  source_descr="error of example.txt";
  source_path="src/example.text";
  source_line=2;
  source_start=1;
  source_end=5;
  source_code=100
}

let test_uri_of_message _ =
  let actual = Review_comment.uri_of_message (init ()) error_detail in
  let expect = "https://github.com/holyshared/typesafety/blob/master/src/example.text#L2" in
  assert_equal actual expect

let test_hint_of_message _ =
  let hint_line = Review_comment.(
    Comment_buffer.(
      create () |>
      hint_of_message ~msg:error_detail |>
      contents
    )
  ) in
  assert_equal "^^^^^\n" hint_line

let test_create_review_comment _ =
  let user = "holyshared" in
  let repo = "typesafety" in
  let branch = "master" in
  let review_comment = Review_comment.branch_for ~user ~repo ~branch () in
  let expect = Template.read_template ~file:"../tests/fixtures/review_comment.txt" () in
  let json = Template.json_from ~file:"../tests/fixtures/output.json" ~f:result_of_string () in
  let actual = review_comment ~json:json in
  assert_equal expect actual

let tests =
  "all_tests" >::: [
    ("test_uri_of_message" >:: test_uri_of_message);
    ("test_hint_of_message" >:: test_hint_of_message);
    ("create review comment" >:: test_create_review_comment);
  ]
