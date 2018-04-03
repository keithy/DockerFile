#!/bin/sh

# create dummy index.php if does not exists

if [ ! -f /shared/html/index.php ]; then
  echo "<html>
  <body>
    <h1>It Works!</h1>
    Apache/php5 on Alpine with Docker container <a href=https://hub.docker.com/r/keithy/alpine3.7-apache2.4-php5.6.33/>keithy/alpine3.7-apache2.4-php5.6.33</a>
    <br>BUILD : <?php echo file_get_contents('/etc/BUILD'); ?>
    <br>PHP version <?php echo phpversion(); ?>
  </body>
</html>" > /shared/html/index.php
  chown -R apache.apache /shared/html
fi
