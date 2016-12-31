FROM holyshared/ocaml:latest
MAINTAINER Noritaka Horio <holy.shared.design@gmail.com>
RUN sudo apt-get -y update
RUN sudo apt-get -y install software-properties-common
RUN sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN sudo add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main"
RUN sudo apt-get -y update
RUN sudo apt-get -y install hhvm
RUN opam switch 4.04.0
RUN eval `opam config env`
RUN opam install atdgen cmdliner process oUnit
