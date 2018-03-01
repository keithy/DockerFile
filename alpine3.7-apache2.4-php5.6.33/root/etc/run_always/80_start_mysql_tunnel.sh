#!/bin/sh

if [ ! -d /var/run/mysqld ]; then
	mkdir /var/run/mysqld
fi

if [ -f /var/run/mysqld/mysqld.sock ]; then
	rm /var/run/mysqld/mysqld.sock
fi

ssh -NT4 -L/var/run/mysqld/mysqld.sock:localhost:3306 edit3.pul &

/bin/sleep 2

chmod 777 /var/run/mysqld/mysqld.sock