(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Typechecker

val create: ?root: string ->
  slug:Github.Slug.t ->
  branch:Github.Branch.t ->
  Typechecker_check_t.result -> string
