#!/bin/sh

# copy index.html if html directory does not exists

if [ ! -d /shared/html ]; then
  mkdir /shared/html
  cp -RpP /etc/apache2/html/* /shared/html/
  chown -R apache.apache /shared/html
fi
