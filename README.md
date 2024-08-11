# fatras

> A collection of experiments serving (ideally) as an incubator for more
> ambitious projects

### Setting up the development environment

To work, we assume that a version greater than or equal to `2.2.0~beta1` of
[OPAM](https://opam.ocaml.org) is installed on your machine ([Install
OPAM](https://opam.ocaml.org/doc/Install.html), [upgrade to version
`2.2.0~xxxx`](https://opam.ocaml.org/blog/opam-2-2-0-beta2/#Try-it)).

> [!TIP]  
> We're relying on version `2.2.x` to support the `dev-setup` flag, which allows
> development dependencies to be packaged, making it very practical to install
> locally all the elements needed to create a pleasant development environment.

When you have a suitable version of OPAM, you can run the following command to
build a [local switch](https://opam.ocaml.org/blog/opam-local-switches/) to
create a sandboxed environment (with a good version of OCaml, and all the
dependencies installed locally).

```shell
opam update
opam switch create . --deps-only --with-dev-setup --with-test --with-doc -y
eval $(opam env)
```

And that's all there is to it. Launching `dune build` should build the project!
The setup should work with Vim and Emacs (if they are configured to work with
OCaml) and with any editor configured to use LSP (Merlin and OCaml-lsp-server
being development dependencies of the project).

