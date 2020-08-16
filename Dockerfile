FROM terrorjack/asterius:200702

RUN apt-get update
RUN apt-get install nano

RUN ahc-cabal v1-update

RUN cabal v2-update
RUN cabal v2-install hpack -j --constraint='hpack == 0.34.2' --installdir=/bin --install-method=copy
