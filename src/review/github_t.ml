(* Auto-generated from "github.atd" *)


type review_user = {
  id: int;
  user_type: string;
  login: string;
  avatar_url: string;
  gravatar_id: string;
  url: string;
  html_url: string;
  followers_url: string;
  following_url: string;
  gists_url: string;
  starred_url: string;
  subscriptions_url: string;
  organizations_url: string;
  repos_url: string;
  events_url: string;
  received_events_url: string;
  site_admin: bool
}

type review_link_pull_request = { href: string }

type review_link_html = { href: string }

type review_links = {
  html: review_link_html;
  pull_request: review_link_pull_request
}

type review_result = {
  id: int;
  user: review_user;
  body: string;
  state: string;
  html_url: string;
  pull_request_url: string;
  _links: review_links;
  submitted_at: string;
  commit_id: string
}

type draft_review_comment = { path: string; position: int; body: string }

type review = {
  body: string;
  event: string;
  comments: (draft_review_comment list) option
}
