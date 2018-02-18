FROM nimmis/alpine-micro:3.7
MAINTAINER Keith keithy@consultant.com

# based upon nimmis/alpine-apache-php5

COPY root/. /

RUN	apk update && apk upgrade && \

	printf "Build of keithy/alpine-apache-php56, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \

	apk add php5-apache2 php5-pdo_mysql php5-mysql apache2-utils && \
	
	# aiming to be minimal
	# apk add openssl php5-openssl php5-fpm php5-pgsql php5-sqlite3 php5-phar && \
    # apk add  php5-apcu php5-intl php5-imagick && \
    # apk add php5-mcrypt php5-json php5-gd php5-curl && \
    # cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer&& \

    chown -R apache.www-data /web && \
    
    # we get our config files from nimmis/alpine-apache-php5 so we dont need to set up our own

	# fix compatible with old scripts
    ln -s /usr/bin/php5 /usr/bin/php && \
    
    echo "short_open_tag = On" > /etc/php5/conf.d/our_settings.ini && \
    echo "memory_limit = 256M" >> /etc/php5/conf.d/our_settings.ini && \
    
    #clear cache
    rm -rf /var/cache/apk/*

VOLUME /web
VOLUME /var/www/html
VOLUME /server

EXPOSE 85





