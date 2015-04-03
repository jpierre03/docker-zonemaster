FROM perl
MAINTAINER Jean-Pierre PRUNARET <jean-pierre+git@prunetwortk.fr>

RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get -y install git build-essential \
    libldns-dev \
    libjson-perl \
    libnet-ip-perl libfile-sharedir-perl

RUN perl -MCPAN -e 'install File::ReadBackwards'	\
 && perl -MCPAN -e 'install File::ShareDir'		\
 && perl -MCPAN -e 'install File::Slurp'		\
 && perl -MCPAN -e 'install Getopt::Long::Descriptive'	\
 && perl -MCPAN -e 'install Hash::Merge'		\
 && perl -MCPAN -e 'install IO::Socket::INET6'		\
 && perl -MCPAN -e 'install List::MoreUtils'		\
 && perl -MCPAN -e 'install Locale::TextDomain'

RUN perl -MCPAN -e 'install Mail::RFC822::Address'	\
 && perl -MCPAN -e 'install Module::Install'		\
 && perl -MCPAN -e 'install Module::Find'		\
 && perl -MCPAN -e 'install Moose'			\
 && perl -MCPAN -e 'install MooseX::Getopt'		\
 && perl -MCPAN -e 'install Net::IP::XS'		\
 && perl -MCPAN -e 'install Net::LDNS'

RUN perl -MCPAN -e 'install Text::Reflow'		\
 && perl -MCPAN -e 'install Readonly'

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
