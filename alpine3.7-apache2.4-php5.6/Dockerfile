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

    apk add apache2 libxml2 apache2-utils && \
    mkdir /web/ && chown -R apache.apache /web && \

    sed -i 's#^DocumentRoot ".*#DocumentRoot "/shared/html"#g' /etc/apache2/httpd.conf && \
    sed -i 's#AllowOverride [Nn]one#AllowOverride All#' /etc/apache2/httpd.conf && \
    sed -i 's#^ServerRoot .*#ServerRoot /web#g'  /etc/apache2/httpd.conf && \
    sed -i 's/^#ServerName.*/ServerName webproxy/' /etc/apache2/httpd.conf && \
    sed -i 's#^IncludeOptional /etc/apache2/conf#IncludeOptional /shared/config/conf#g' /etc/apache2/httpd.conf && \
    sed -i 's#PidFile "/run/.*#Pidfile "/tmp/run/httpd.pid"#g'  /etc/apache2/conf.d/mpm.conf && \
    sed -i 's#Directory "/var/www/localhost/htdocs.*#Directory "/web/html" >#g' /etc/apache2/httpd.conf && \
    sed -i 's#Directory "/var/www/localhost/cgi-bin.*#Directory "/shared/config/cgi-bin" >#g' /etc/apache2/httpd.conf && \

    sed -i 's#/var/log/apache2/#/logs/#g' /etc/logrotate.d/apache2 && \
    sed -i 's/Options Indexes/Options /g' /etc/apache2/httpd.conf && \


	# MEMCACHED

	apk add memcached && \

	# PHP

	apk add php5-apache2 php5-pdo_mysql php5-mysql apache2-utils php5-json && \

	ln -s /usr/bin/php5 /usr/bin/php && \

	# for .phar support for tracy
	apk add php5-phar php5-zlib php5-iconv && \
	
	# for captcha processing
	apk add php5-gd && \ 

	# PHP5 XDEBUG
	apk add ca-certificates && \
	wget --quiet --output-document=/etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
	wget https://github.com/sgerrand/alpine-pkg-php5-xdebug/releases/download/2.5.5-r0/php5-xdebug-2.5.5-r0.apk && \

	apk add php5-xdebug-2.5.5-r0.apk && \

	# aiming to be minimal we will leave these for now
	#
	# apk add openssl php5-openssl php5-fpm php5-pgsql php5-sqlite3 php5-phar && \
    # apk add php5-apcu php5-intl php5-imagick && \
    # apk add php5-mcrypt php5-json php5-gd php5-curl && \
    # cd /tmp && curl -sS https://getcomposer.org/installer | php5 && mv composer.phar /usr/local/bin/composer && \

	#PHP5-MEMCACHED

	apk add ca-certificates &&\
	wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-php5-memcached/master/sgerrand.rsa.pub &&\
	wget https://github.com/sgerrand/alpine-pkg-php5-memcached/releases/download/2.2.0-r0/php5-memcached-2.2.0-r0.apk &&\
	apk add php5-memcached-2.2.0-r0.apk &&\

    chown -R apache.apache /web && \
       	
	#PHP5-LIBSODIUM
	apk add libsodium-dev php5-pear php5-dev g++ autoconf make && \
	#fix pecl
	sed -i "$ s|\-n||g" /usr/bin/pecl && \		
	pecl install libsodium-1.0.7 && \
	echo "extension=libsodium.so" > /etc/php5/conf.d/libsodium.ini && \
	
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






