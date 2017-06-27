(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

module type S = sig
  val post: Uri.t ->
    headers:(string * string) list ->
    body:string ->
    (int * string, int * string) Result.result Lwt.t
end

val post: Uri.t ->
  headers:(string * string) list ->
  body:string ->
  (int * string, int * string) Result.result Lwt.t
