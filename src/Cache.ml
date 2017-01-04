module SourceFileName = struct
  type t = string
  let equal = (=)
  let hash = Hashtbl.hash
end

module Cache = Hashtbl.Make(SourceFileName)

include Cache
