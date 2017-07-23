(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

module type S = sig
  val check_version: unit -> (string, string) result Lwt.t
  val parse_version: string -> (Hhvm_version.t, string) result
  val print_version: Hhvm_version.t -> unit
end

module Make(S: Process.S) : S
