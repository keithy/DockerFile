FROM nimmis/alpine-micro:3.7
MAINTAINER Keith keithy@consultant.com

COPY root/. /

RUN	apk update && apk upgrade && \

	printf "Build of keithy/website-staging-toolkit, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \

	apk add ruby git
	
    #clear cache
    rm -rf /var/cache/apk/*

VOLUME /var/www





