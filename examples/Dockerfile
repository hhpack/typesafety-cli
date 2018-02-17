FROM ubuntu:16.04
LABEL maintainer "Noritaka Horio <holy.shared.design@gmail.com>"
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
RUN echo 'eval `opam config env`' >> ~/.profile
RUN sudo -u typesafety sh -c "opam init -y"
RUN sudo -u typesafety sh -c "opam switch 4.05.0"
RUN sudo -u typesafety sh -c "opam depext conf-openssl.1"
RUN sudo -u typesafety sh -c "opam install -y jbuilder ssl lwt lwt_ssl ocamlfind atdgen cmdliner oUnit cohttp cohttp-lwt-unix"
COPY src src
COPY typesafefy_src typesafefy_src
COPY typesafety.descr typesafety.descr
COPY typesafety.opam typesafety.opam
COPY Makefile Makefile
COPY typesafety-build typesafety-build
RUN sudo chown -R typesafety:typesafety typesafefy_src src typesafety.opam typesafety.descr Makefile typesafety-build
RUN sudo -u typesafety sh -c "./typesafety-build"
