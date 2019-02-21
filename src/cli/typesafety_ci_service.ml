open Env

module Env_adapter: Env_adapter.S = struct
  let get = Sys.getenv_opt
end

module Travis = Ci_service_env.Travis
module Circle_ci = Ci_service_env.Circle_ci
module General = Ci_service_env.General

module Current_supports = struct
  let supports = [
    (module Travis: Ci_service_env.Service);
    (module Circle_ci: Ci_service_env.Service);
    (module General: Ci_service_env.Service)
  ]
end
