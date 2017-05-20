(* Auto-generated from "github.atd" *)


type review_user = Github_t.review_user = {
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

type review_link_pull_request = Github_t.review_link_pull_request = {
  href: string
}

type review_link_html = Github_t.review_link_html = { href: string }

type review_links = Github_t.review_links = {
  html: review_link_html;
  pull_request: review_link_pull_request
}

type review_result = Github_t.review_result = {
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

type draft_review_comment = Github_t.draft_review_comment = {
  path: string;
  position: int;
  body: string
}

type review = Github_t.review = {
  body: string;
  event: string;
  comments: (draft_review_comment list) option
}

val write_review_user :
  Bi_outbuf.t -> review_user -> unit
  (** Output a JSON value of type {!review_user}. *)

val string_of_review_user :
  ?len:int -> review_user -> string
  (** Serialize a value of type {!review_user}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_review_user :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> review_user
  (** Input JSON data of type {!review_user}. *)

val review_user_of_string :
  string -> review_user
  (** Deserialize JSON data of type {!review_user}. *)

val write_review_link_pull_request :
  Bi_outbuf.t -> review_link_pull_request -> unit
  (** Output a JSON value of type {!review_link_pull_request}. *)

val string_of_review_link_pull_request :
  ?len:int -> review_link_pull_request -> string
  (** Serialize a value of type {!review_link_pull_request}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_review_link_pull_request :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> review_link_pull_request
  (** Input JSON data of type {!review_link_pull_request}. *)

val review_link_pull_request_of_string :
  string -> review_link_pull_request
  (** Deserialize JSON data of type {!review_link_pull_request}. *)

val write_review_link_html :
  Bi_outbuf.t -> review_link_html -> unit
  (** Output a JSON value of type {!review_link_html}. *)

val string_of_review_link_html :
  ?len:int -> review_link_html -> string
  (** Serialize a value of type {!review_link_html}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_review_link_html :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> review_link_html
  (** Input JSON data of type {!review_link_html}. *)

val review_link_html_of_string :
  string -> review_link_html
  (** Deserialize JSON data of type {!review_link_html}. *)

val write_review_links :
  Bi_outbuf.t -> review_links -> unit
  (** Output a JSON value of type {!review_links}. *)

val string_of_review_links :
  ?len:int -> review_links -> string
  (** Serialize a value of type {!review_links}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_review_links :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> review_links
  (** Input JSON data of type {!review_links}. *)

val review_links_of_string :
  string -> review_links
  (** Deserialize JSON data of type {!review_links}. *)

val write_review_result :
  Bi_outbuf.t -> review_result -> unit
  (** Output a JSON value of type {!review_result}. *)

val string_of_review_result :
  ?len:int -> review_result -> string
  (** Serialize a value of type {!review_result}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_review_result :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> review_result
  (** Input JSON data of type {!review_result}. *)

val review_result_of_string :
  string -> review_result
  (** Deserialize JSON data of type {!review_result}. *)

val write_draft_review_comment :
  Bi_outbuf.t -> draft_review_comment -> unit
  (** Output a JSON value of type {!draft_review_comment}. *)

val string_of_draft_review_comment :
  ?len:int -> draft_review_comment -> string
  (** Serialize a value of type {!draft_review_comment}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_draft_review_comment :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> draft_review_comment
  (** Input JSON data of type {!draft_review_comment}. *)

val draft_review_comment_of_string :
  string -> draft_review_comment
  (** Deserialize JSON data of type {!draft_review_comment}. *)

val write_review :
  Bi_outbuf.t -> review -> unit
  (** Output a JSON value of type {!review}. *)

val string_of_review :
  ?len:int -> review -> string
  (** Serialize a value of type {!review}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_review :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> review
  (** Input JSON data of type {!review}. *)

val review_of_string :
  string -> review
  (** Deserialize JSON data of type {!review}. *)

