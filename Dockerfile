FROM holyshared/ocaml:latest
ENV DEBIAN_FRONTEND noninteractive
LABEL maintainer "Noritaka Horio <holy.shared.design@gmail.com>"
RUN sudo -u develop sh -c 'opam install -y dune ssl lwt lwt_ssl ocamlfind atdgen cmdliner oUnit cohttp cohttp-lwt-unix'
WORKDIR project
COPY Makefile Makefile
COPY src src
COPY tests tests
COPY examples examples
COPY .travis .travis
COPY typesafety.opam typesafety.opam
COPY typesafety.descr typesafety.descr
RUN sudo chown -R develop:develop src tests examples .travis typesafety.opam typesafety.descr
