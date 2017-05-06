(**
 * Copyright 2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

let token ci ~f =
  let module Ci = (val ci: Ci_env.S) in
  match Ci.token () with
    | Ok token -> Ok (f ~token)
    | Error e -> Error e

let slug ci ~f =
  let module Ci = (val ci: Ci_env.S) in
  match Ci.slug () with
    | Ok slug ->
      let user, repo = slug in
      Ok (f ~user ~repo)
    | Error e -> Error e

let branch ci ~f =
  let module Ci = (val ci: Ci_env.S) in
  match Ci.branch () with
    | Ok branch -> Ok (f ~branch)
    | Error e -> Error e

let pull_request_number ci ~f =
  let module Ci = (val ci: Ci_env.S) in
  match Ci.pull_request_number () with
    | Ok num -> Ok (f ~num)
    | Error e -> Error e

let bind_with o ~f ~ci =
  match o with
    | Ok bind_f -> f ci ~f:bind_f
    | Error e -> Error e

let bind_ci_env_vars f ~ci =
  let bind f = bind_with ~f ~ci in
  (Ok f) |>
  bind token |>
  bind slug |>
  bind branch |>
  bind pull_request_number

let bind_args_of_review f =
  match Ci_env.detect () with
    | Ok ci -> bind_ci_env_vars f ~ci
    | Error e -> Error e
