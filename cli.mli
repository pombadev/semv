module Semver : Semantic_version.S

type part = [`Major | `Minor | `Patch]

type t = { version: Semver.t; part: part }

val parse : unit -> t

val preserve : bool ref
