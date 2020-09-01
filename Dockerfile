FROM terrorjack/asterius:200702

ARG jobs=
ARG hpack_version=0.34.2

RUN cabal v2-update
RUN cabal v2-install hpack -j$jobs --constraint="hpack == $hpack_version" --installdir=/bin --install-method=copy

RUN ahc-cabal v1-update

RUN apt-get update
RUN apt-get install nano
