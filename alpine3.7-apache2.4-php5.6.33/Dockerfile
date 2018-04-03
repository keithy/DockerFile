FROM nimmis/alpine-micro:3.7
MAINTAINER Keith keithy@consultant.com

# based upon nimmis/alpine-apache-php5

COPY root/. /

# first remove edge repositories

RUN	printf "Build of keithy/alpine-apache-php:php5.6.33, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILDS/alpine-apache-php && \

    # UPDATE

    # first remove edge repositories
    sed -i '/\/edge\//d' /etc/apk/repositories && \
	apk update && apk upgrade && \

    # SSH

    apk --upgrade add openssh-client && \
  	echo "UserKnownHostsFile /.ssh-agent/known_hosts" >> /etc/ssh/ssh_config && \

	# APACHE

    apk add apache2 libxml2 apache2-utils apache2-ssl && \
    mkdir /web/ && chown -R apache.apache /web && \

    sed -i 's#^DocumentRoot ".*#DocumentRoot "/shared/html"#g' /etc/apache2/httpd.conf && \
    sed -i 's#AllowOverride [Nn]one#AllowOverride All#' /etc/apache2/httpd.conf && \
    sed -i 's#^ServerRoot .*#ServerRoot /web#g'  /etc/apache2/httpd.conf && \
    sed -i 's/^#ServerName.*/ServerName webproxy/' /etc/apache2/httpd.conf && \
    sed -i 's#^IncludeOptional /etc/apache2/conf#IncludeOptional /shared/config/conf#g' /etc/apache2/httpd.conf && \
    sed -i 's#PidFile "/run/.*#Pidfile "/var/run/httpd.pid"#g'  /etc/apache2/conf.d/mpm.conf && \
    sed -i 's#Directory "/var/www/localhost/htdocs.*#Directory "/shared/html" >#g' /etc/apache2/httpd.conf && \
    sed -i 's#Directory "/var/www/localhost/cgi-bin.*#Directory "/shared/config/cgi-bin" >#g' /etc/apache2/httpd.conf && \

    sed -i 's#/var/log/apache2/#/logs/#g' /etc/logrotate.d/apache2 && \
    sed -i 's/Options Indexes/Options /g' /etc/apache2/httpd.conf && \


	# MEMCACHED

	apk add memcached && \

	# PHP

	apk add php5-apache2 php5-pdo_mysql php5-mysql php5-json openssl && \

	# aiming to be minimal we will leave these for now
	#
	# apk add  php5-openssl php5-fpm php5-pgsql php5-sqlite3 php5-phar && \
    # apk add  php5-apcu php5-intl php5-imagick && \
    # apk add php5-mcrypt php5-json php5-gd php5-curl && \
    # cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer&& \

	#PHP5-MEMCACHED

	apk add ca-certificates &&\
	wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-php5-memcached/master/sgerrand.rsa.pub &&\
	wget https://github.com/sgerrand/alpine-pkg-php5-memcached/releases/download/2.2.0-r0/php5-memcached-2.2.0-r0.apk &&\
	apk add php5-memcached-2.2.0-r0.apk &&\

    chown -R apache.apache /web && \
         
    #clear cache
    rm -rf /var/cache/apk/*

ENV MYSQL_HOST="240.1.1.1"

#VOLUME /backup
VOLUME /server
VOLUME /shared
VOLUME /logs
VOLUME /web
VOLUME /var/www/

EXPOSE 80



