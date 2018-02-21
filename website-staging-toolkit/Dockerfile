FROM nimmis/alpine-micro:3.7
MAINTAINER Keith keithy@consultant.com

COPY root/. /

RUN	sed -i '/\/edge\//d' /etc/apk/repositories && \

	apk update && apk upgrade && \

	printf "Build of keithy/website-staging-toolkit, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILDS/website-staging-toolkit && \

	apk add ruby git &&\
	
    #clear cache
    rm -rf /var/cache/apk/*

VOLUME /var/www





