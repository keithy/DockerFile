FROM nimmis/alpine-micro:3.7
MAINTAINER Keith keithy@consultant.com

# based upon nimmis/alpine-apache-56

COPY root/. /

RUN	printf "Build of keithy/alpine-apache-php56, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \

	apk --no-cache add php5-apache2 php5-pdo_mysql php5-mysql libxml2-dev apache2-utils && \
	
	# apk --no-cache add openssl php5-openssl php5-fpm php5-pgsql php5-sqlite3 php5-phar && \
    # apk --no-cache add  php5-apcu php5-intl php5-imagick && \
    # apk --no-cache add php5-mcrypt php5-json php5-gd php5-curl 
    # cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer&& \

    chown -R apache.www-data /web

    # we got our config files from nimmis/alpine-apache-php5 so we dont need to set up our own

VOLUME /web
VOLUME /var/www/html
VOLUME /server

EXPOSE 80

