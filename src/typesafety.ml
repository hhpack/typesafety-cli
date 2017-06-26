(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Cmdliner

let () =
  Term.exit @@ (Term.eval (Typesafety_check.check_t, Typesafety_check.info))
