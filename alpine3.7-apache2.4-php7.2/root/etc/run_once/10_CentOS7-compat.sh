#!/bin/sh

# make link /usr/bin/php ->  /usr/bin/php5 if missing

# mirroring CentOS7 organisation /etc/httpd/conf/httpd.conf

if [ ! -d /etc/httpd ]; then
  ln -s /web /etc/httpd
fi

if [ ! -f /etc/mime.types ]; then
  ln -s /etc/apache2/mime.types /etc/mime.types
fi
	