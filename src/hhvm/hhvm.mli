(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type version = {
  version: string;
  compiler: string;
  repo_schema: string;
}

val check_version: unit -> (string, string) result
val parse_version: string -> (version, string) result
val print_version: version -> unit
