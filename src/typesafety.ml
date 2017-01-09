(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Cmdliner

let program_terminate = function
  | `Error _ -> exit 1
  | _ -> exit 0

let () =
  program_terminate (Term.eval (TypesafetyCheck.check_t, TypesafetyCheck.info))
