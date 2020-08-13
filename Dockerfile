FROM terrorjack/asterius:200702

RUN ahc-cabal v1-update
RUN cabal v2-update

ENV PATH="/project/bin:${PATH}"
