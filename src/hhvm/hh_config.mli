(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type absolute_path = string

type hhconfig_result =
  | AlreadyExists of absolute_path
  | FileCreated of absolute_path

val config_file: string
val config_path: ?dir:string -> unit -> string

val string_of_result: hhconfig_result -> string

val touch: string -> (hhconfig_result, string) result

val create_if: ?dir:string -> no_hhconfig:bool -> unit -> (hhconfig_result, string) result
