#!/bin/sh

# provide a location for server specific php.ini files

if [ ! -d /web/config/php5 ]; then
  mkdir /web/config/php5
  mv /etc/php7/conf.d/*_our_* /web/config/php5
  chown -R apache.apache /web/php5
fi
