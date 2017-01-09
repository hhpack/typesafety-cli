(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

module SourceFileName = struct
  type t = string
  let equal = (=)
  let hash = Hashtbl.hash
end

module Cache = Hashtbl.Make(SourceFileName)

include Cache
