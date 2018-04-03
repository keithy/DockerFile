#!/bin/sh

# create an info.php

if [ ! -f /shared/html/info.php ]; then

	echo "<?php phpinfo(); " > /shared/html/info.php
	chown -R apache.apache /shared/html

fi