FROM nimmis/alpine-micro:3.7
MAINTAINER Keith keithy@consultant.com

# based upon nimmis/alpine-apache-php5

COPY root/. /

RUN	apk update && apk upgrade && \

	printf "Build of keithy/alpine-apache-php56, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` >> /etc/BUILD && \

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

	apk add php5-apache2 php5-pdo_mysql php5-mysql apache2-utils && \
	
	# aiming to be minimal
	# apk add openssl php5-openssl php5-fpm php5-pgsql php5-sqlite3 php5-phar && \
    # apk add  php5-apcu php5-intl php5-imagick && \
    # apk add php5-mcrypt php5-json php5-gd php5-curl && \
    # cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer&& \

    chown -R apache.apache /web && \
    
    # we get our config files from nimmis/alpine-apache-php5 so we dont need to set up our own

    echo "short_open_tag = On" > /etc/php5/conf.d/our_settings.ini && \
    echo "memory_limit = 256M" >> /etc/php5/conf.d/our_settings.ini && \
    
    #clear cache
    rm -rf /var/cache/apk/*

VOLUME /web
VOLUME /var/www/html-A
VOLUME /var/www/html-B
VOLUME /server

EXPOSE 80





