module Semver = Semantic_version.Make ()

type part = [`Major | `Minor | `Patch]

type t = { version: Semver.t; part: part }

let usage = "semv [-major] [-minor] [-patch] +/- <input>"

let input = ref None

let part = ref None

let preserve = ref false

let read_input () =
  let buffer = Buffer.create 1024 in
  try
    while true do
      Buffer.add_channel buffer stdin 1
    done;
    Buffer.contents buffer
  with End_of_file -> Buffer.contents buffer

let die msg =
  prerr_endline ("semv: " ^ msg);
  exit 1

let parse () =
  let () =
    Arg.parse
      [
        ("-major", Arg.Unit (fun () -> part := Some `Major), "Set major");
        ("-minor", Arg.Unit (fun () -> part := Some `Minor), "Set minor");
        ("-patch", Arg.Unit (fun () -> part := Some `Patch), "Set patch");
        ( "-preserve",
          Arg.Unit (fun () -> preserve := not !preserve),
          "By default pre-release and build info are discarded after \
           modification, use this to preserve them." );
      ]
      (fun ver ->
        match !input with
        | Some _ ->
            die "<input> cannot be multiple"
        | None ->
            input := Some ver )
      usage
  in
  let version =
    let is_pipe = Unix.isatty Unix.stdin |> not in
    let version =
      if is_pipe then read_input ()
      else
        match !input with Some ver -> ver | None -> die "<input> is required"
    in
    try Semver.of_string version with _ -> die "<input> is not a valid semver"
  in
  let part =
    match !part with Some part -> part | None -> die "<part> is required"
  in
  { version; part }
