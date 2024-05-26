open Cli

let print_semver ~old ~current =
  let info =
    let ret = ref "" in
    let pre = Semver.pre_release_tags old |> String.concat "" in
    let build = Semver.build_metadata old |> String.concat "" in

    if String.length pre > 0 then ret := !ret ^ "-" ^ pre;

    if String.length build > 0 then ret := !ret ^ "+" ^ build;

    !ret
  in

  print_endline (Semver.to_string current ^ if !preserve then info else "")

let incr ~part ~version =
  let updated =
    match part with
    | `Major -> Semver.next_major_release version
    | `Minor -> Semver.next_minor_release version
    | `Patch -> Semver.next_patch_release version
  in
  print_semver ~old:version ~current:updated

let () =
  let { part; version } = Cli.parse () in
  incr ~part ~version
