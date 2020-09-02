FROM terrorjack/asterius:200702

RUN apt-get update && apt-get install nano

RUN ahc-cabal v1-update

VOLUME /project
WORKDIR /project
