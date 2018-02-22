FROM nimmis/alpine-micro:edge
MAINTAINER Keith keithy@consultant.com

COPY root/. /

RUN	apk update && apk upgrade && \

	printf "Build of keithy/website-staging-toolkit, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILDS/website-staging-toolkit && \

	apk add git nano rsync &&\

	apk add ruby ruby-rake &&\

	apk add ruby-rspec &&\

	gem install thor && \
	
    #clear cache
    rm -rf /var/cache/apk/*

VOLUME /rules
VOLUME /var/www





