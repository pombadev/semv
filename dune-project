(lang dune 3.15)

(name semv)

(version 1.0.0)

(generate_opam_files true)

(source
 (github pombadev/semv))

(bug_reports https://github.com/pombadev/semv/issues)

(homepage https://github.com/pombadev/semv)

(authors "pombadev")

(maintainers "pombadev")

(license Apache-2.0)

(package
 (name semv)
 (synopsis "Bump a semver")
 (depends (semantic_version (= v0.16.0)))
 (tags
  (semver cli)))
