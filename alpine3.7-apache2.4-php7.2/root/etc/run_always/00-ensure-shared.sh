#!/bin/sh

# create /shared/config if not present

if [ ! -d /shared/config ]; then
  mkdir -p /shared/config
  chown -R apache.apache /shared/config
fi


if [ ! -f /shared/config/httpd.conf ]; then
  cp -R /etc/apache2/* /shared/config/
  chown -R apache.apache /shared/config
fi

if [ ! -d /shared/cgi-bin ]; then
  mkdir /shared/cgi-bin
  chown -R apache.apache /shared/cgi-bin
fi

if [ ! -d /shared/internal ]; then
  mkdir /shared/internal
  cp -RpP /etc/apache2/internal/* /shared/internal/
  chown -R apache.apache /shared/internal
fi

