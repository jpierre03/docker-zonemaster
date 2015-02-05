FROM perl
MAINTAINER Jean-Pierre PRUNARET <jean-pierre+git@prunetwortk.fr>

RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get -y install git build-essential \
    libldns-dev \
    libjson-perl \
    libnet-ip-perl libfile-sharedir-perl

RUN perl -MCPAN -e 'install File::ReadBackwards'
RUN perl -MCPAN -e 'install File::ShareDir'
RUN perl -MCPAN -e 'install File::Slurp'
RUN perl -MCPAN -e 'install Getopt::Long::Descriptive'
RUN perl -MCPAN -e 'install Hash::Merge'
RUN perl -MCPAN -e 'install IO::Socket::INET6'
RUN perl -MCPAN -e 'install List::MoreUtils'
RUN perl -MCPAN -e 'install Locale::TextDomain'

RUN perl -MCPAN -e 'install Mail::RFC822::Address'
RUN perl -MCPAN -e 'install Module::Install'
RUN perl -MCPAN -e 'install Module::Find'
RUN perl -MCPAN -e 'install Moose'
RUN perl -MCPAN -e 'install MooseX::Getopt'
RUN perl -MCPAN -e 'install Net::IP::XS'
RUN perl -MCPAN -e 'install Net::LDNS'

RUN perl -MCPAN -e 'install Text::Reflow'
RUN perl -MCPAN -e 'install Readonly'

RUN git clone https://github.com/dotse/zonemaster-engine.git
RUN git clone https://github.com/dotse/zonemaster-cli.git
RUN cd /root/zonemaster-engine \
	&& perl Makefile.PL \
	&& make \
	&& make test \
	&& make install

RUN cd /root/zonemaster-cli \
	&& perl Makefile.PL \
	&& make \
	&& make test \
	&& make install
