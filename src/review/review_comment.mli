(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Typechecker_check_t

type t = {
  user: Github.User.t;
  repo: Github.Repository.t;
  branch: Github.Branch.t;
  root: string;
}

module Message: sig
  type t
  val path_from: ?root: string -> t -> string
  val uri_of: ?root: string -> t -> string
end

val create: ?root: string ->
  user:Github.User.t ->
  repo:Github.Repository.t ->
  branch:Github.Branch.t ->
  Typechecker_check_t.result -> string

val branch_for: user:Github.User.t ->
  repo:Github.Repository.t ->
  branch:Github.Branch.t ->
  (?root: string -> Typechecker_check_t.result -> string)
