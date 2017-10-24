(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

val verbose: bool ref
val verbose_on: unit -> unit
val verbose_off: unit -> unit
val set_verbose: bool -> unit

val debug: ('a, unit, string, string, string, unit) format6 -> 'a
val info: ('a, unit, string, string, string, unit) format6 -> 'a
val warn: ('a, unit, string, string, string, unit) format6 -> 'a
val error: ('a, unit, string, string, string, unit) format6 -> 'a
val success: ('a, unit, string, string, string, unit) format6 -> 'a
val fail: ('a, unit, string, string, string, unit) format6 -> 'a
