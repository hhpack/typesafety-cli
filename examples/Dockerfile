FROM ubuntu:16.04
MAINTAINER Noritaka Horio <holy.shared.design@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get -y install software-properties-common
RUN apt-get -y install sudo m4 opam pkg-config libssl-dev
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main"
RUN sudo apt-get -y update
RUN sudo apt-get -y install hhvm
RUN adduser --disabled-password --gecos "" typesafety
RUN passwd -l typesafety
ADD typesafetysudo /etc/sudoers.d/typesafety
RUN chmod 440 /etc/sudoers.d/typesafety
RUN chown root:root /etc/sudoers.d/typesafety
RUN chown -R typesafety:typesafety /home/typesafety
USER typesafety
ENV HOME /home/typesafety
WORKDIR /home/typesafety
RUN mkdir projects
RUN echo 'eval `opam config env`' >> ~/.profile
RUN sudo -u typesafety sh -c "opam init -y"
RUN sudo -u typesafety sh -c "opam switch 4.04.1"
RUN sudo -u typesafety sh -c "opam depext conf-openssl.1"
RUN sudo -u typesafety sh -c "opam install oasis ocamlfind camlp4 atdgen lwt lwt_ssl cohttp cmdliner oUnit"
