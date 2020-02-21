FROM skeuchel/coq:base
LABEL maintainer="steven.keuchel@gmail.com"

ARG BUILD_DATE
ARG VCS_REF
ARG COQ_COMMIT
ARG COQ_VERSION


ENV COQ_VERSION="${COQ_VERSION}"
ENV COQ_EXTRA_OPAM="coq-bignums coq-equations coq-iris"

RUN ["/bin/bash", "--login", "-c", "set -x \
    && eval $(opam env --switch=${COMPILER} --set-switch) \
    && opam repository add --all-switches --set-default coq-extra-dev https://coq.inria.fr/opam/extra-dev \
    && opam repository add --all-switches --set-default coq-core-dev https://coq.inria.fr/opam/core-dev \
    && opam update -y -u \
    && opam pin add -n -y -k git coq.${COQ_VERSION} \"git+https://github.com/coq/coq#${COQ_COMMIT}\" \
    && opam pin add -n -y -k version coq-equations dev \
    && opam install -y -v coq ${COQ_EXTRA_OPAM} \
    && opam clean -a -c -s --logs \
    && opam config list && opam list"]
