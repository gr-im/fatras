(lang dune 3.16)
(name fatras)
(version dev)
(generate_opam_files)
(executables_implicit_empty_intf)

(source (github gr-im/fatras))
(license MIT)
(authors "Pierre Grim <grimfw@gmail.com>")
(maintainers "Pierre Grim <grimfw@gmail.com>")

(package
  (name fatras)
  (synopsis "Common libraries and dev dependencies")
  (description "Fatras is a Bazar of OCaml experiences")
  (depends
    (ocaml (>= 5.1.1))
    (dune (>= 3.16.0))

   (ppx_expect :with-test)

   (ocamlformat :with-dev-setup)
   (ocp-indent :with-dev-setup)
   (merlin :with-dev-setup)
   (utop :with-dev-setup)
   (ocaml-lsp-server :with-dev-setup)

   (odoc :with-doc)
   (sherlodoc :with-doc)))
