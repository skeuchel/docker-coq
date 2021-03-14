FROM coqorg/base:4.07.1-flambda
LABEL maintainer="steven.keuchel@gmail.com"

ENV COQ_VERSION="8.11.2"
ENV COQ_EXTRA_OPAM="coq-bbv coq-bignums coq-equations coq-hierarchy-builder coq-iris"

RUN ["/bin/bash", "--login", "-c", "set -x \
  && eval $(opam env --switch=${COMPILER} --set-switch) \
  && opam update -y -u \
  && opam pin add -n -k version coq ${COQ_VERSION} \
  && opam install -y -v coq ${COQ_EXTRA_OPAM} \
  && opam clean -a -c -s --logs \
  && opam config list && opam list"]
