FROM nimmis/alpine-micro:edge
MAINTAINER Keith keithy@consultant.com

COPY root/. /

RUN	apk update && apk upgrade && \

	printf "Build of keithy/website-staging-toolkit, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILDS/website-staging-toolkit && \

	apk add git nano rsync &&\

	apk add ruby ruby-rake ruby-rspec ruby-rdoc  && \

	gem install thor rio && \

	# http://www.rubydoc.info/gems/tty-command
	gem install tty-command pastel && \

    #clear cache
    rm -rf /var/cache/apk/*

VOLUME /rules
VOLUME /var/www





