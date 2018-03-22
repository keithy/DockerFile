#!/bin/sh

if [ ! -d /web/modules ]; then
  ln -s /usr/lib/apache2 /web/modules
fi