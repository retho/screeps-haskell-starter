FROM terrorjack/asterius:200702

VOLUME /workspace
WORKDIR /workspace

ARG force_update=no
RUN ahc-cabal v1-update
