#!/bin/sh

# create /web if not present

if [ ! -d /web/config ]; then
  mkdir /web/config
  chown -R apache.apache /web/config
fi