FROM nimmis/alpine-micro:3.7
MAINTAINER Keith keithy@consultant.com

# based upon nimmis/alpine-apache-php7

ARG IMAGE_NAME
ARG DOCKER_REPO
ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="keith <keithy@consultant.com>" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.name="Apache2/php7 on Alpine OS" \
      org.label-schema.url="https://github.com/keithy" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/keithy/docker.git"

COPY root/. /

# trust this project public key to trust the packages.
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

RUN apk update && apk upgrade && \

	#printf "Build of %s, date: %s\n" $(echo $IMAGE_NAME | sed 's#^.*io/##')  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/$(echo $DOCKER_REPO | awk -F '/' '{print $NF}') && \
	printf "Build of keithy/alpine-apache-php72, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \

	#APACHE

    apk add apache2 libxml2 apache2-utils && \
    mkdir /web/ && chown -R apache.apache /web && \
   
    sed -i 's#^DocumentRoot ".*#DocumentRoot "/web/html"#g' /etc/apache2/httpd.conf && \
    sed -i 's#AllowOverride [Nn]one#AllowOverride All#' /etc/apache2/httpd.conf && \
    sed -i 's#^ServerRoot .*#ServerRoot /web#g'  /etc/apache2/httpd.conf && \
    sed -i 's/^#ServerName.*/ServerName webproxy/' /etc/apache2/httpd.conf && \
    sed -i 's#^IncludeOptional /etc/apache2/conf#IncludeOptional /web/config/conf#g' /etc/apache2/httpd.conf && \
    sed -i 's#PidFile "/run/.*#Pidfile "/web/run/httpd.pid"#g'  /etc/apache2/conf.d/mpm.conf && \
    sed -i 's#Directory "/var/www/localhost/htdocs.*#Directory "/web/html" >#g' /etc/apache2/httpd.conf && \
    sed -i 's#Directory "/var/www/localhost/cgi-bin.*#Directory "/web/cgi-bin" >#g' /etc/apache2/httpd.conf && \

    sed -i 's#/var/log/apache2/#/web/logs/#g' /etc/logrotate.d/apache2 && \
    sed -i 's/Options Indexes/Options /g' /etc/apache2/httpd.conf && \

	#PHP

	# add the repository, make sure you replace the correct versions if you want.
	 echo "@php https://php.codecasts.rocks/v3.7/php-7.2" >> /etc/apk/repositories  && \

	apk add --update php7@php &&\
	apk add --update php7-mbstring@php &&\
 

    apk add php7-apache2@php php7-openssl@php && \
    apk add php7-apcu@php php7-intl@php php7-json@php php7-gd@php php7-curl@php && \
    apk add php7-fpm@php php7-mysqlnd@php php7-phar@php && \
    
    apk add php7-pdo_mysql@php php7-mysqli@php && \
    
    apk add php7-libsodium@php php7-memcached@php && \
    
    # removed php7-pgsql@php php7-sqlite3@php php7-mcrypt@php

    apk add php7-imagick@php && \
    
	# leave composer for now
	#
    # apk add libressl && \
    # apk add curl openssl && \
    # cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && \
    
    #clear cache
    rm -rf /var/cache/apk/*

VOLUME /web
VOLUME /var/www
VOLUME /server

EXPOSE 80

