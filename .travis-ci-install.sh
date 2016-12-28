export OPAMYES=1

install_on_linux() {
  sudo add-apt-repository -y ppa:avsm/ocaml42+opam12
  sudo apt-get update -qq
  sudo apt-get install -qq m4 ocaml opam
}

install_on_osx() {
  brew update &> /dev/null
  brew install opam
}

case $TRAVIS_OS_NAME in
  osx) install_on_osx ;;
  linux) install_on_linux ;;
esac

opam init
opam install oasis ocamlfind atdgen cmdliner process oUnit
