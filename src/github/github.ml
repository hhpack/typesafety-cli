module String_value = struct
  include String
  let is_empty v = if (length v) <= 0 then true else false
end

module Token = String_value
module Branch = String_value
module User = String_value
module Repository = String_value
module Pull_request = struct
  type t = int
  let equal v1 v2 = v1 = v2
  let compare v1 v2 = compare v1 v2
  let to_string n = string_of_int n
  let of_string s = int_of_string s
end

module Slug = struct
  type t = (string * string)
  let of_string s =
    let slug_len = String.length s in
    let slug_sp_index = String.index s '/' in
    let user = String.sub s 0 slug_sp_index in
    let repo_len = (slug_len - (String.length user) - 1) in
    let repo = String.sub s (slug_sp_index + 1) repo_len in
    (user, repo)
  let to_string t =
    let user, repo = t in
    user ^ "/" ^ repo
end
