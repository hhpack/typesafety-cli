(* Auto-generated from "github.atd" *)


type draft_review_comment = { path: string; position: int; body: string }

type review = {
  body: string;
  event: string;
  comments: (draft_review_comment list) option
}
