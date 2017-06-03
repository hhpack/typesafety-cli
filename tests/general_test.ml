open Test_helper
open Ci_env
open Github

let test_current_env ctxt =
  let module S = Ci_env.General.Make(struct
    let get key = match key with
      | "CI" -> Some "true"
      | _ -> Some "false"
  end) in
  assert_bool "current env is false" (S.is_current ())

let test_not_current_env ctxt =
  let module S = Ci_env.General.Make(struct
    let get key = match key with
      | "CI" -> Some "false"
      | _ -> Some "false"
  end) in
  assert_bool "current env is true" (not (S.is_current ()))

let test_slug ctxt =
  let module S = Ci_env.General.Make(struct
    let get key = match key with
      | "CI_PULL_REQUEST_SLUG" -> Some "holyshared/typesafey"
      | _ -> None
  end) in
  let expect = Slug.to_string ("holyshared", "typesafey") in
  let actual slug =
    match slug with
      | Ok v -> Slug.to_string v
      | Error _ -> "invalid slug" in
  assert_equal expect (actual (S.slug ()))

let tests =
  "all_tests" >::: [
    ("test_current_env" >:: test_current_env);
    ("test_not_current_env" >:: test_not_current_env);
    ("test_slug" >:: test_slug)
  ]
