#!/bin/sh

# make link /usr/bin/php ->  /usr/bin/php5 if missing

if [ ! -f /usr/bin/php ]; then
  ln -s /usr/bin/php5 /usr/bin/php
fi

