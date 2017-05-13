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

let write_review_user : _ -> review_user -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"id\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"type\":";
    (
      Yojson.Safe.write_string
    )
      ob x.user_type;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"login\":";
    (
      Yojson.Safe.write_string
    )
      ob x.login;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"avatar_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.avatar_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"gravatar_id\":";
    (
      Yojson.Safe.write_string
    )
      ob x.gravatar_id;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"html_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.html_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"followers_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.followers_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"following_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.following_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"gists_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.gists_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"starred_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.starred_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"subscriptions_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.subscriptions_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"organizations_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.organizations_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"repos_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.repos_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"events_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.events_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"received_events_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.received_events_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"site_admin\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.site_admin;
    Bi_outbuf.add_char ob '}';
)
let string_of_review_user ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_review_user ob x;
  Bi_outbuf.contents ob
let read_review_user = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_id = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_user_type = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_login = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_avatar_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_gravatar_id = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_html_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_followers_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_following_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_gists_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_starred_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_subscriptions_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_organizations_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_repos_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_events_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_received_events_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_site_admin = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 2 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                  0
                )
                else (
                  -1
                )
              )
            | 3 -> (
                if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'l' then (
                  5
                )
                else (
                  -1
                )
              )
            | 4 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' then (
                  1
                )
                else (
                  -1
                )
              )
            | 5 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' then (
                  2
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'l' then (
                  6
                )
                else (
                  -1
                )
              )
            | 9 -> (
                match String.unsafe_get s pos with
                  | 'g' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'l' then (
                        9
                      )
                      else (
                        -1
                      )
                    )
                  | 'r' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'l' then (
                        13
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 10 -> (
                match String.unsafe_get s pos with
                  | 'a' -> (
                      if String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'u' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'l' then (
                        3
                      )
                      else (
                        -1
                      )
                    )
                  | 'e' -> (
                      if String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'u' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'l' then (
                        14
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'd' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'n' then (
                        16
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 11 -> (
                match String.unsafe_get s pos with
                  | 'g' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'd' then (
                        4
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'd' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'l' then (
                        10
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 13 -> (
                if String.unsafe_get s pos = 'f' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'w' then (
                  match String.unsafe_get s (pos+6) with
                    | 'e' -> (
                        if String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'l' then (
                          7
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'l' then (
                          8
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
                else (
                  -1
                )
              )
            | 17 -> (
                match String.unsafe_get s pos with
                  | 'o' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'z' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'u' && String.unsafe_get s (pos+15) = 'r' && String.unsafe_get s (pos+16) = 'l' then (
                        12
                      )
                      else (
                        -1
                      )
                    )
                  | 's' -> (
                      if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'p' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'u' && String.unsafe_get s (pos+15) = 'r' && String.unsafe_get s (pos+16) = 'l' then (
                        11
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 19 -> (
                if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'v' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'v' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = 't' && String.unsafe_get s (pos+14) = 's' && String.unsafe_get s (pos+15) = '_' && String.unsafe_get s (pos+16) = 'u' && String.unsafe_get s (pos+17) = 'r' && String.unsafe_get s (pos+18) = 'l' then (
                  15
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_id := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_user_type := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_login := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_avatar_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_gravatar_id := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_html_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_followers_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_following_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x100;
          | 9 ->
            field_gists_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x200;
          | 10 ->
            field_starred_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x400;
          | 11 ->
            field_subscriptions_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x800;
          | 12 ->
            field_organizations_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1000;
          | 13 ->
            field_repos_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2000;
          | 14 ->
            field_events_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4000;
          | 15 ->
            field_received_events_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8000;
          | 16 ->
            field_site_admin := (
              (
                Ag_oj_run.read_bool
              ) p lb
            );
            bits0 := !bits0 lor 0x10000;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 2 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 3 -> (
                  if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'l' then (
                    5
                  )
                  else (
                    -1
                  )
                )
              | 4 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'y' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'e' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'n' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'l' then (
                    6
                  )
                  else (
                    -1
                  )
                )
              | 9 -> (
                  match String.unsafe_get s pos with
                    | 'g' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'l' then (
                          9
                        )
                        else (
                          -1
                        )
                      )
                    | 'r' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'o' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'u' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 'l' then (
                          13
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 10 -> (
                  match String.unsafe_get s pos with
                    | 'a' -> (
                        if String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'u' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'l' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | 'e' -> (
                        if String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'u' && String.unsafe_get s (pos+8) = 'r' && String.unsafe_get s (pos+9) = 'l' then (
                          14
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'd' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'n' then (
                          16
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 11 -> (
                  match String.unsafe_get s pos with
                    | 'g' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'd' then (
                          4
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'd' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'r' && String.unsafe_get s (pos+10) = 'l' then (
                          10
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 13 -> (
                  if String.unsafe_get s pos = 'f' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'w' then (
                    match String.unsafe_get s (pos+6) with
                      | 'e' -> (
                          if String.unsafe_get s (pos+7) = 'r' && String.unsafe_get s (pos+8) = 's' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'l' then (
                            7
                          )
                          else (
                            -1
                          )
                        )
                      | 'i' -> (
                          if String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'g' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'r' && String.unsafe_get s (pos+12) = 'l' then (
                            8
                          )
                          else (
                            -1
                          )
                        )
                      | _ -> (
                          -1
                        )
                  )
                  else (
                    -1
                  )
                )
              | 17 -> (
                  match String.unsafe_get s pos with
                    | 'o' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'z' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'u' && String.unsafe_get s (pos+15) = 'r' && String.unsafe_get s (pos+16) = 'l' then (
                          12
                        )
                        else (
                          -1
                        )
                      )
                    | 's' -> (
                        if String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'i' && String.unsafe_get s (pos+7) = 'p' && String.unsafe_get s (pos+8) = 't' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'o' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 's' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'u' && String.unsafe_get s (pos+15) = 'r' && String.unsafe_get s (pos+16) = 'l' then (
                          11
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 19 -> (
                  if String.unsafe_get s pos = 'r' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'v' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'd' && String.unsafe_get s (pos+8) = '_' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'v' && String.unsafe_get s (pos+11) = 'e' && String.unsafe_get s (pos+12) = 'n' && String.unsafe_get s (pos+13) = 't' && String.unsafe_get s (pos+14) = 's' && String.unsafe_get s (pos+15) = '_' && String.unsafe_get s (pos+16) = 'u' && String.unsafe_get s (pos+17) = 'r' && String.unsafe_get s (pos+18) = 'l' then (
                    15
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_id := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_user_type := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_login := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_avatar_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_gravatar_id := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_html_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_followers_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_following_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x100;
            | 9 ->
              field_gists_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x200;
            | 10 ->
              field_starred_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x400;
            | 11 ->
              field_subscriptions_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x800;
            | 12 ->
              field_organizations_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1000;
            | 13 ->
              field_repos_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2000;
            | 14 ->
              field_events_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4000;
            | 15 ->
              field_received_events_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8000;
            | 16 ->
              field_site_admin := (
                (
                  Ag_oj_run.read_bool
                ) p lb
              );
              bits0 := !bits0 lor 0x10000;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1ffff then Ag_oj_run.missing_fields p [| !bits0 |] [| "id"; "user_type"; "login"; "avatar_url"; "gravatar_id"; "url"; "html_url"; "followers_url"; "following_url"; "gists_url"; "starred_url"; "subscriptions_url"; "organizations_url"; "repos_url"; "events_url"; "received_events_url"; "site_admin" |];
        (
          {
            id = !field_id;
            user_type = !field_user_type;
            login = !field_login;
            avatar_url = !field_avatar_url;
            gravatar_id = !field_gravatar_id;
            url = !field_url;
            html_url = !field_html_url;
            followers_url = !field_followers_url;
            following_url = !field_following_url;
            gists_url = !field_gists_url;
            starred_url = !field_starred_url;
            subscriptions_url = !field_subscriptions_url;
            organizations_url = !field_organizations_url;
            repos_url = !field_repos_url;
            events_url = !field_events_url;
            received_events_url = !field_received_events_url;
            site_admin = !field_site_admin;
          }
         : review_user)
      )
)
let review_user_of_string s =
  read_review_user (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_review_link_pull_request : _ -> review_link_pull_request -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"href\":";
    (
      Yojson.Safe.write_string
    )
      ob x.href;
    Bi_outbuf.add_char ob '}';
)
let string_of_review_link_pull_request ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_review_link_pull_request ob x;
  Bi_outbuf.contents ob
let read_review_link_pull_request = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_href = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 4 && String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'f' then (
            0
          )
          else (
            -1
          )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_href := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            if len = 4 && String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'f' then (
              0
            )
            else (
              -1
            )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_href := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1 then Ag_oj_run.missing_fields p [| !bits0 |] [| "href" |];
        (
          {
            href = !field_href;
          }
         : review_link_pull_request)
      )
)
let review_link_pull_request_of_string s =
  read_review_link_pull_request (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_review_link_html : _ -> review_link_html -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"href\":";
    (
      Yojson.Safe.write_string
    )
      ob x.href;
    Bi_outbuf.add_char ob '}';
)
let string_of_review_link_html ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_review_link_html ob x;
  Bi_outbuf.contents ob
let read_review_link_html = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_href = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          if len = 4 && String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'f' then (
            0
          )
          else (
            -1
          )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_href := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            if len = 4 && String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'f' then (
              0
            )
            else (
              -1
            )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_href := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1 then Ag_oj_run.missing_fields p [| !bits0 |] [| "href" |];
        (
          {
            href = !field_href;
          }
         : review_link_html)
      )
)
let review_link_html_of_string s =
  read_review_link_html (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_review_links : _ -> review_links -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"html\":";
    (
      write_review_link_html
    )
      ob x.html;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"pull_request\":";
    (
      write_review_link_pull_request
    )
      ob x.pull_request;
    Bi_outbuf.add_char ob '}';
)
let string_of_review_links ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_review_links ob x;
  Bi_outbuf.contents ob
let read_review_links = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_html = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_pull_request = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 4 -> (
                if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'l' then (
                  0
                )
                else (
                  -1
                )
              )
            | 12 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'q' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 't' then (
                  1
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_html := (
              (
                read_review_link_html
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_pull_request := (
              (
                read_review_link_pull_request
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 4 -> (
                  if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'l' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'q' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 't' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_html := (
                (
                  read_review_link_html
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_pull_request := (
                (
                  read_review_link_pull_request
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "html"; "pull_request" |];
        (
          {
            html = !field_html;
            pull_request = !field_pull_request;
          }
         : review_links)
      )
)
let review_links_of_string s =
  read_review_links (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_review_result : _ -> review_result -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"id\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"user\":";
    (
      write_review_user
    )
      ob x.user;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"body\":";
    (
      Yojson.Safe.write_string
    )
      ob x.body;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"state\":";
    (
      Yojson.Safe.write_string
    )
      ob x.state;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"html_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.html_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"pull_request_url\":";
    (
      Yojson.Safe.write_string
    )
      ob x.pull_request_url;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"_links\":";
    (
      write_review_links
    )
      ob x._links;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"submitted_at\":";
    (
      Yojson.Safe.write_string
    )
      ob x.submitted_at;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"commit_id\":";
    (
      Yojson.Safe.write_string
    )
      ob x.commit_id;
    Bi_outbuf.add_char ob '}';
)
let string_of_review_result ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_review_result ob x;
  Bi_outbuf.contents ob
let read_review_result = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_id = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_user = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_body = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_state = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_html_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_pull_request_url = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field__links = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_submitted_at = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_commit_id = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 2 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                  0
                )
                else (
                  -1
                )
              )
            | 4 -> (
                match String.unsafe_get s pos with
                  | 'b' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'y' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 'u' -> (
                      if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 5 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' then (
                  3
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = '_' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'k' && String.unsafe_get s (pos+5) = 's' then (
                  6
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'l' then (
                  4
                )
                else (
                  -1
                )
              )
            | 9 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'd' then (
                  8
                )
                else (
                  -1
                )
              )
            | 12 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' then (
                  7
                )
                else (
                  -1
                )
              )
            | 16 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'q' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = '_' && String.unsafe_get s (pos+13) = 'u' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'l' then (
                  5
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_id := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_user := (
              (
                read_review_user
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_body := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_state := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_html_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_pull_request_url := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field__links := (
              (
                read_review_links
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | 7 ->
            field_submitted_at := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x80;
          | 8 ->
            field_commit_id := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x100;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 2 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 4 -> (
                  match String.unsafe_get s pos with
                    | 'b' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'y' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 'u' -> (
                        if String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'e' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = '_' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'k' && String.unsafe_get s (pos+5) = 's' then (
                    6
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'l' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = '_' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'd' then (
                    8
                  )
                  else (
                    -1
                  )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'b' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'e' && String.unsafe_get s (pos+8) = 'd' && String.unsafe_get s (pos+9) = '_' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 't' then (
                    7
                  )
                  else (
                    -1
                  )
                )
              | 16 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'q' && String.unsafe_get s (pos+8) = 'u' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 's' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = '_' && String.unsafe_get s (pos+13) = 'u' && String.unsafe_get s (pos+14) = 'r' && String.unsafe_get s (pos+15) = 'l' then (
                    5
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_id := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_user := (
                (
                  read_review_user
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_body := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_state := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_html_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_pull_request_url := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field__links := (
                (
                  read_review_links
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | 7 ->
              field_submitted_at := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x80;
            | 8 ->
              field_commit_id := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x100;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1ff then Ag_oj_run.missing_fields p [| !bits0 |] [| "id"; "user"; "body"; "state"; "html_url"; "pull_request_url"; "_links"; "submitted_at"; "commit_id" |];
        (
          {
            id = !field_id;
            user = !field_user;
            body = !field_body;
            state = !field_state;
            html_url = !field_html_url;
            pull_request_url = !field_pull_request_url;
            _links = !field__links;
            submitted_at = !field_submitted_at;
            commit_id = !field_commit_id;
          }
         : review_result)
      )
)
let review_result_of_string s =
  read_review_result (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_draft_review_comment : _ -> draft_review_comment -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"path\":";
    (
      Yojson.Safe.write_string
    )
      ob x.path;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"position\":";
    (
      Yojson.Safe.write_int
    )
      ob x.position;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"body\":";
    (
      Yojson.Safe.write_string
    )
      ob x.body;
    Bi_outbuf.add_char ob '}';
)
let string_of_draft_review_comment ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_draft_review_comment ob x;
  Bi_outbuf.contents ob
let read_draft_review_comment = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_path = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_position = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_body = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 4 -> (
                match String.unsafe_get s pos with
                  | 'b' -> (
                      if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'y' then (
                        2
                      )
                      else (
                        -1
                      )
                    )
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' then (
                  1
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_path := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_position := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_body := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 4 -> (
                  match String.unsafe_get s pos with
                    | 'b' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'y' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'h' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_path := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_position := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_body := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x7 then Ag_oj_run.missing_fields p [| !bits0 |] [| "path"; "position"; "body" |];
        (
          {
            path = !field_path;
            position = !field_position;
            body = !field_body;
          }
         : draft_review_comment)
      )
)
let draft_review_comment_of_string s =
  read_draft_review_comment (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__1 = (
  Ag_oj_run.write_list (
    write_draft_review_comment
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    read_draft_review_comment
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__2 = (
  Ag_oj_run.write_option (
    fun ob x ->
      Bi_outbuf.add_char ob '(';
      (let x = x in
      (
        write__1
      ) ob x
      );
      Bi_outbuf.add_char ob ')';
  )
)
let string_of__2 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__2 ob x;
  Bi_outbuf.contents ob
let read__2 = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 then (
                  match String.unsafe_get s pos with
                    | 'N' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                          0
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | 'S' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                          1
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | _ -> (
                        raise (Exit)
                      )
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (None : _ option)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read__1
                          ) p lb
                        in
                        incr len;
                        (try
                          Yojson.Safe.read_space p lb;
                          Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                        with Yojson.End_of_tuple -> end_of_tuple := true);
                        x
                      in
                      if not !end_of_tuple then (
                        try
                          while true do
                            Yojson.Safe.skip_json p lb;
                            Yojson.Safe.read_space p lb;
                            Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                          done
                        with Yojson.End_of_tuple -> ()
                      );
                      (x0)
                    with Yojson.End_of_tuple ->
                      Ag_oj_run.missing_tuple_fields p !len [ 0 ]);
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 && String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              (None : _ option)
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 && String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            read__1
                          ) p lb
                        in
                        incr len;
                        (try
                          Yojson.Safe.read_space p lb;
                          Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                        with Yojson.End_of_tuple -> end_of_tuple := true);
                        x
                      in
                      if not !end_of_tuple then (
                        try
                          while true do
                            Yojson.Safe.skip_json p lb;
                            Yojson.Safe.read_space p lb;
                            Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                          done
                        with Yojson.End_of_tuple -> ()
                      );
                      (x0)
                    with Yojson.End_of_tuple ->
                      Ag_oj_run.missing_tuple_fields p !len [ 0 ]);
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
)
let _2_of_string s =
  read__2 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_review : _ -> review -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"body\":";
    (
      Yojson.Safe.write_string
    )
      ob x.body;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"event\":";
    (
      Yojson.Safe.write_string
    )
      ob x.event;
    (match x.comments with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"comments\":";
      (
        fun ob x ->
          Bi_outbuf.add_char ob '(';
          (let x = x in
          (
            write__1
          ) ob x
          );
          Bi_outbuf.add_char ob ')';
      )
        ob x;
    );
    Bi_outbuf.add_char ob '}';
)
let string_of_review ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_review ob x;
  Bi_outbuf.contents ob
let read_review = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_body = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_event = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_comments = ref (None) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 4 -> (
                if String.unsafe_get s pos = 'b' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'y' then (
                  0
                )
                else (
                  -1
                )
              )
            | 5 -> (
                if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 't' then (
                  1
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 's' then (
                  2
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_body := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_event := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_comments := (
                Some (
                  (
                    fun p lb ->
                      Yojson.Safe.read_space p lb;
                      let std_tuple = Yojson.Safe.start_any_tuple p lb in
                      let len = ref 0 in
                      let end_of_tuple = ref false in
                      (try
                        let x0 =
                          let x =
                            (
                              read__1
                            ) p lb
                          in
                          incr len;
                          (try
                            Yojson.Safe.read_space p lb;
                            Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                          with Yojson.End_of_tuple -> end_of_tuple := true);
                          x
                        in
                        if not !end_of_tuple then (
                          try
                            while true do
                              Yojson.Safe.skip_json p lb;
                              Yojson.Safe.read_space p lb;
                              Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                            done
                          with Yojson.End_of_tuple -> ()
                        );
                        (x0)
                      with Yojson.End_of_tuple ->
                        Ag_oj_run.missing_tuple_fields p !len [ 0 ]);
                  ) p lb
                )
              );
            )
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 4 -> (
                  if String.unsafe_get s pos = 'b' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'y' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 'e' && String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 't' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 's' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_body := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_event := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_comments := (
                  Some (
                    (
                      fun p lb ->
                        Yojson.Safe.read_space p lb;
                        let std_tuple = Yojson.Safe.start_any_tuple p lb in
                        let len = ref 0 in
                        let end_of_tuple = ref false in
                        (try
                          let x0 =
                            let x =
                              (
                                read__1
                              ) p lb
                            in
                            incr len;
                            (try
                              Yojson.Safe.read_space p lb;
                              Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                            with Yojson.End_of_tuple -> end_of_tuple := true);
                            x
                          in
                          if not !end_of_tuple then (
                            try
                              while true do
                                Yojson.Safe.skip_json p lb;
                                Yojson.Safe.read_space p lb;
                                Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                              done
                            with Yojson.End_of_tuple -> ()
                          );
                          (x0)
                        with Yojson.End_of_tuple ->
                          Ag_oj_run.missing_tuple_fields p !len [ 0 ]);
                    ) p lb
                  )
                );
              )
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "body"; "event" |];
        (
          {
            body = !field_body;
            event = !field_event;
            comments = !field_comments;
          }
         : review)
      )
)
let review_of_string s =
  read_review (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
