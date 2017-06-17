FROM holyshared/ocaml:latest
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Noritaka Horio <holy.shared.design@gmail.com>
RUN sudo -u develop sh -c 'opam install -y oasis ssl lwt_ssl ocamlfind atdgen cmdliner process oUnit cohttp lwt'
