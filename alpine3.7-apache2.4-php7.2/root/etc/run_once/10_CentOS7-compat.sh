#!/bin/sh

# mirroring CentOS7 organisation /etc/httpd/conf/httpd.conf

if [ ! -d /etc/httpd ]; then
  ln -s /web /etc/httpd
fi

if [ ! -f /etc/mime.types ]; then
  ln -s /etc/apache2/mime.types /etc/mime.types
fi
	