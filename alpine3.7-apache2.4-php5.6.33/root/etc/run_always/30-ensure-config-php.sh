#!/bin/sh

# provide a location for server specific php.ini files

if [ ! -d /shared/config/php ]; then
  mkdir /shared/config/php
  mv /shared/php/conf.d/*_our_* /shared/config/php
  chown -R apache.apache /shared/php
fi
