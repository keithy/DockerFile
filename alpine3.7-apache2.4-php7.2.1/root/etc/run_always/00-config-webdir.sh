#!/bin/sh

# create /web/config if not present

if [ ! -d /web/config ]; then
  mkdir -p /web/config
  chown -R apache.apache /web/config
fi