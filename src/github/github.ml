(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

module User = struct
  type t = string
  let is_empty v = if (String.length v) <= 0 then true else false
  let of_string s = s
  let to_string s = s
end

module Token = struct
  type t = string
  let is_empty v = if (String.length v) <= 0 then true else false
  let of_string s = s
  let to_string s = s
end

module Branch = struct
  type t = string
  let is_empty v = if (String.length v) <= 0 then true else false
  let of_string s = s
  let to_string s = s
end

module Repository = struct
  type t = string
  let is_empty v = if (String.length v) <= 0 then true else false
  let of_string s = s
  let to_string s = s
end

module Pull_request = struct
  type t = int
  let equal v1 v2 = v1 = v2
  let compare = compare
  let to_int n = n
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
    (User.of_string user, Repository.of_string repo)

  (** Return owner of github repository *)
  let repo_name t =
    let _, repo = t in
    Repository.of_string repo

  (** Return owner of github repository *)
  let repo_owner t =
    let user, _ = t in
    User.of_string user

  let to_string t =
    let user, repo = t in
    (User.to_string user) ^ "/" ^ (Repository.to_string repo)
end
