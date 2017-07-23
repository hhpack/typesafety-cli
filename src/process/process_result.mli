(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type t

val create: status:int -> string -> t
val status: t -> int
val output: t -> string
val is_ok: t -> bool
val is_error: t -> bool
val to_string: t -> string
val return_ok: t -> (string, string) result Lwt.t
val return_error: t -> msg:string -> (string, string) result Lwt.t
