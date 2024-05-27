open Cli

let print_semver ~old ~current =
  let info =
    if !preserve then
      let pre = Semver.pre_release_tags old |> String.concat "" in
      let build = Semver.build_metadata old |> String.concat "" in
      let pre = if String.length pre > 0 then "-" ^ pre else "" in
      if String.length build > 0 then pre ^ "+" ^ build else pre
    else ""
  in
  print_endline (Semver.to_string current ^ info)

let incr ({ part; version } : Cli.t) =
  let updated =
    match part with
    | `Major ->
        Semver.next_major_release version
    | `Minor ->
        Semver.next_minor_release version
    | `Patch ->
        Semver.next_patch_release version
  in
  print_semver ~old:version ~current:updated

let () = Cli.parse () |> incr
