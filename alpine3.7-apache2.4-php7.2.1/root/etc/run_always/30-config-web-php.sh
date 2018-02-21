#!/bin/sh

# provide a location for server specific php.ini files

if [ ! -d /web/config/php7 ]; then
  mkdir /web/config/php7
  mv /etc/php7/conf.d/*_our_* /web/config/php7
  chown -R apache.apache /web/php7
fi
