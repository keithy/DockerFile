#!/bin/sh

if [ ! -d /web/conf ]; then
  ln -s /shared/httpd/conf /web/conf
fi

if [ ! -d /web/conf.d ]; then
  ln -s /shared/httpd/conf. /web/conf.d
fi

if [ ! -d /web/conf.modules.d ]; then
  ln -s /shared/httpd/conf.modules.d /web/conf.modules.d
fi

if [ ! -d /web/modules ]; then
  ln -s /usr/lib/apache2 /web/modules
fi

if [ ! -d /web/sites-enabled ]; then
  ln -s /shared/httpd/sites-enabled /web/sites-enabled
fi

if [ ! -d /web/logs ]; then
  ln -s /logs /web/logs
fi

