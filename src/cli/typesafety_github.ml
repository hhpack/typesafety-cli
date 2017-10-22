open Review
open Misc.Log
open Typesafety_ci_service

module Review = Github_review.Make (Current_supports) (Env_adapter) (Http_client)

type review_result =
  | Skiped of string
  | Reviewed of Github_t.review_result
  | ReviewFailed of string

let skiped_reason = function
  | Github_review.NoError -> Skiped "Skiped github review (reason: no errors)"
  | Github_review.NotPullRequest -> Skiped "Skiped github review (reason: not pull request)"

let review_success result =
  let open Github_t in
  match result with
    | Github_review.Reviewed json -> Reviewed json
    | Github_review.Skiped v -> skiped_reason v

let on_review result =
  let open Github_t in
  match result with
    | Skiped v -> Ok (info "%s\n" v)
    | Reviewed json -> Ok (info "The review was successful\n%s\n" json.pull_request_url)
    | ReviewFailed e -> Error e

let create_review json =
  match Review.create json with
    | Ok v -> review_success v
    | Error e -> ReviewFailed e

let skip_review json = Skiped "Skiped github review"

let review_if json ~review =
  let try_review json =
    if review then
      create_review json
    else
      skip_review json in
  try_review json |> on_review
