(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

module Source_name = struct
  type t = string
  let equal = (=)
  let hash = Hashtbl.hash
end

module Source_cache = MoreLabels.Hashtbl.Make(Source_name)

include Source_cache
