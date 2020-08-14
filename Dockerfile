FROM terrorjack/asterius:200702

RUN apt-get update
RUN apt-get install nano

RUN ahc-cabal v1-update
RUN cabal v2-update

ENV PATH="/project/bin:${PATH}"
