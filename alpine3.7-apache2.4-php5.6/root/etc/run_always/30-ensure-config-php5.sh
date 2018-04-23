#!/bin/sh

# provide a location for shared specific php.ini files

if [ ! -d /shared/config/php5 ]; then
  mkdir /shared/config/php5
  mv /etc/php5/conf.d/*_our_* /shared/config/php5
  chown -R apache.apache /shared/config/php5
fi

cp /shared/config/php5/*.ini /etc/php5/conf.d 

# import server specific php.ini files

cp /web/*.ini /etc/php5/conf.d

chown -R apache.apache /etc/php7/conf.d