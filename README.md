# typesafety-cli

[![Build Status](https://travis-ci.org/hhpack/typesafety-cli.svg?branch=master)](https://travis-ci.org/hhpack/typesafety-cli)

![Screen Shot](https://github.com/hhpack/typesafety-cli/blob/master/screenshot.png?raw=true)

Typesafety is a type checker wrapper for [Hack](http://hacklang.org/).  
Detailed report at type check, automatic generation of .hhconfig, etc.


## Basic usage

Execute the following command in the directory where typecheck is to be performed.

	typesafety

If you want to know detailed specification method, execute the following command.

	typesafety --help

## Build

You can build with the following command.

	make build

### Environment

The following environment is necessary to build.

* OCaml >= 4.04.0
* Opam >= 1.2.2

### Dependent packages

You can install dependent packages with the following command.

	opam switch 4.04.0
	opam install oasis ocamlfind atdgen cmdliner process oUnit

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
