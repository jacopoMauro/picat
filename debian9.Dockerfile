FROM debian:stretch
MAINTAINER Jacopo Mauro

RUN apt-get update && \
	apt-get install -y \
		wget && \
	apt-get -y install openssh-client && \
 	rm -rf /var/lib/apt/lists/* && \
	mkdir /tool && \
	cd /tool && \
	wget http://picat-lang.org/download/picat26_linux64.tar.gz  && \
	tar xvfz picat26_linux64.tar.gz && \
	rm picat26_linux64.tar.gz && \
	mv Picat picat && \
	cd picat && \
	wget http://picat-lang.org/flatzinc/fzn_picat_sat.pi  && \
	wget http://picat-lang.org/flatzinc/fzn_picat_cp.pi  && \
	wget http://picat-lang.org/flatzinc/fzn_parser.pi  && \
	wget http://picat-lang.org/flatzinc/fzn_tokenizer.pi && \
	echo '#! /bin/sh \n\
/tool/picat/picat /tool/picat/fzn_picat_sat  "$@"' > /tool/picat/fzn-picat && \
	chmod 700 fzn-picat && \
	wget http://picat-lang.org/flatzinc/picat_globals.tar.gz && \
	tar xvfz picat_globals.tar.gz && \
	rm picat_globals.tar.gz && \
	mv globals mzn-lib

ENV PATH "$PATH:/tool/picat/"

# minizinc lib available at /tool/picat/mzn-lib
