#!/bin/sh

# populate /logs if empty

if [ ! -d /logs ]; then
  mkdir /logs
  chown -R apache.apache /logs
fi