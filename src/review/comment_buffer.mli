(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type t
val create: ?size:int -> unit -> t
val spaces: n:int -> string
val write: t -> s:string -> t
val write_wrap_s: t -> wrap:string -> s:string -> t
val write_space: t -> n:int -> t
val write_ntimes: t -> c:char -> n:int -> t
val writeln: ?s:string -> ?n:int -> t -> t
val write_with_indent: ?indent:int -> ?ln:int -> s:string -> t -> t
val write_indent: ?n:int -> t -> t
val contents: t -> string
