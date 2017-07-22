(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Log

type t = {
  version: string;
  compiler: string;
  repo_schema: string;
}

let parse_version output =
  let regexp = Str.regexp "HipHop VM \\(.+\\)\nCompiler: \\(.+\\)\nRepo schema: \\(.+\\)" in
  let group n s = Str.matched_group n s in
  let version s = group 1 s in
  let compiler s = group 2 s in
  let repo_schema s = group 3 s in
  if Str.string_match regexp output 0 then
    Ok {
      version=(version output);
      compiler=(compiler output);
      repo_schema=(repo_schema output);
    }
  else
    Error "hhvm not installed"

let print_version v =
  info "Installed hhvm version: %s." v.version
