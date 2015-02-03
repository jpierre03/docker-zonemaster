FROM ubuntu
MAINTAINER Jean-Pierre PRUNARET <jean-pierre+git@prunetwortk.fr>

RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get -y install git build-essential\
    libfile-slurp-perl libjson-perl \
    liblist-moreutils-perl libio-socket-inet6-perl libmodule-find-perl \
    libmoose-perl libnet-ip-perl libfile-sharedir-perl libhash-merge-perl \
    libreadonly-perl libldns-dev libmodule-install-perl \
    libmail-rfc822-address-perl libintl-xs-perl \
    libmoosex-getopt-perl libtext-reflow-perl

RUN perl -MCPAN -e 'install Net::LDNS'
RUN perl -MCPAN -e 'install Net::IP::XS'

RUN git clone https://github.com/dotse/zonemaster-cli.git && cd zonemaster-cli
RUN perl Makefile.PL
RUN make test install

