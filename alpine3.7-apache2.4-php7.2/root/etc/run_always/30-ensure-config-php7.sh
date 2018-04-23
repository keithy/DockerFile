#!/bin/sh

# provide a location for server specific php.ini files

if [ ! -d /shared/config/php7 ]; then
  mkdir /shared/config/php7
  mv /etc/php7/conf.d/*_our_* /shared/config/php7
  chown -R apache.apache /shared/config/php7
fi

cp /shared/config/php7/*.ini /etc/php7/conf.d

# import server specific php.ini files

cp /web/*.ini /etc/php7/conf.d

chown -R apache.apache /etc/php7/conf.d
