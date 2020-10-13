FROM skeuchel/coq:base
LABEL maintainer="steven.keuchel@gmail.com"

ENV COQ_VERSION="8.12.0"
ENV COQ_EXTRA_OPAM="coq-bignums coq-equations coq-hierarchy-builder coq-iris"

# Build coq with both min-version and edge+flambda opam switches

RUN ["/bin/bash", "--login", "-c", "set -x \
  && eval $(opam env --switch=${COMPILER} --set-switch) \
  && opam repo add iris-dev https://gitlab.mpi-sws.org/iris/opam.git \
  && opam update -y -u \
  && opam pin add -n -k version coq ${COQ_VERSION} \
  && opam install -y -v coq ${COQ_EXTRA_OPAM} \
  && opam install -y -v coq-bbv --ignore-constraints-on coq \
  && opam clean -a -c -s --logs \
  && opam config list && opam list"]
