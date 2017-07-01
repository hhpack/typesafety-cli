# typesafety-cli

[![Build Status](https://travis-ci.org/hhpack/typesafety-cli.svg?branch=master)](https://travis-ci.org/hhpack/typesafety-cli)

![Screen Shot](https://github.com/hhpack/typesafety-cli/blob/master/screenshot.png?raw=true)

Typesafety is a type checker wrapper for [Hack](http://hacklang.org/).  
Detailed report at type check, automatic generation of .hhconfig, etc.


## Basis usage

### Typecheck

If you do not want to create **.hhconfig** automatically, specify **--no-hhconfig**.

	typesafety

or

	typesafety --no-hhconfig

### Typecheck and Github review

Using Github review api, you can post the check results as review comments.  
Current version only supports [Travis CI](https://travis-ci.org/).

	typesafety --review

You need to specify [Personal access token](https://github.com/settings/tokens) for environment variable **GITHUB_TOKEN**.  
The access authority must be **repo** or **public_repo**.

## Environment

The following environment is necessary to build.

* OCaml >= 4.04.2
* OPAM >= 1.2.2

## Install

### Dependent packages

You can install dependent packages with the following command.  
If you use the **--review option**, you need to install openssl.

#### Debian/Ubuntu

	sudo apt-get install -y opam
	sudo apt-get install -y libssl-dev pkg-config

#### macOS

	brew install opam
	brew install openssl pkg-config

### Install typesafety

	opam switch 4.04.2
	opam pin add typesafety https://github.com/hhpack/typesafety-cli.git

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
