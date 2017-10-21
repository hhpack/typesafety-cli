(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Typechecker
open Process

module type S = sig
  val typecheck_json: unit -> (Typechecker_check_t.result, string) result Lwt.t
end

module Make(S: Process_exec.S) : S
