#!/bin/sh

# create /web/config/_run_always and _run_once if not present

if [ ! -d /web/config/_run_always ]; then
  mkdir -p /web/config/_run_always
fi

if [ ! -d /web/config/_run_once ]; then
  mkdir -p /web/config/_run_once
 fi

chown -R root.wheel /web/config/_run_once
chown -R root.wheel /web/config/_run_always

set -a
  find /web/config/_run_always -type f -perm /110 -print0 | sort -z | xargs -0 -n 1 env
set +a

