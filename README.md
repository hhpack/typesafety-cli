# typesafety-cli

[![Build Status](https://travis-ci.org/hhpack/typesafety-cli.svg?branch=master)](https://travis-ci.org/hhpack/typesafety-cli)

## Environment

The following environment is necessary to build.

* OCaml >= 4.04.0
* Opam >= 1.2.2

### Dependent packages

You can install dependent packages with the following command.

	opam switch 4.04.0
	opam install oasis ocamlfind atdgen cmdliner process oUnit

## Build

You can build with the following command.

	make build

## Test

You can unit test with the following command.

	make configure CONFIGUREFLAGS=--enable-tests
	make test

## Examples

Run the example you need to install the following.

* docker
* docker-sync
* docker-compose

### Execute of examples

	cd examples
	docker-sync-stack start
