open Env

module Env_adapter: Env_adapter.S

module Travis: Ci_service_env.Service
module General: Ci_service_env.Service

module Current_supports: Ci_detector.Supports_ci.S
