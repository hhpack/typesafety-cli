(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

module LineNumber = struct
  type t = int
  let compare = compare
end

module Lines = Map.Make(LineNumber)

include Lines
