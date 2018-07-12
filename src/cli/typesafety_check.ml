(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

open Lwt.Infix
open Misc.Log
open Hhvm

let next o ~f =
  match o with
    | Ok _ -> f ()
    | Error e -> Lwt.return_error e

let map_next o ~f =
  match o with
    | Ok v -> Lwt.return (f v)
    | Error e -> Lwt.return_error e

let check_hhvm_installed () =
  let open Hhvm_version in
  let open Typesafety_hhvm in
  let start () = Lwt.return_ok (debug "Checking the version of hhvm installed.\n") in
  let print_version v = Ok (debug "Installed hhvm version: %s.\n" v.version) in
  let check_version o = next o ~f:Hhvm.check_version in
  let parse_version o = map_next o ~f:Hhvm.parse_version in
  let print_installed_version o = map_next o ~f:print_version in
  start ()
  >>= check_version
  >>= parse_version
  >>= print_installed_version

let check_hhconfg ?(no_hhconfig=true) () =
  let auto_config_generate o =
    match o with
      | Ok _ -> Hh_config.create_if ~no_hhconfig ()
      | Error e -> Error e in
  let start = Ok (debug "Checking configuration file.\n") in
  let generated = function
    | Ok v -> Ok (debug "%s\n" (Hh_config.string_of_result v))
    | Error e -> Error e in
  Lwt.return (start |> auto_config_generate |> generated)

let typecheck ?(no_hhconfig=false) () =
  let open Typesafety_hhvm in
  let check_hhconfg = next ~f:(check_hhconfg ~no_hhconfig) in
  let typecheck_json = next ~f:(Hh_client.typecheck_json) in

  Lwt_main.run (
    check_hhvm_installed ()
    >>= check_hhconfg
    >>= typecheck_json
  )
