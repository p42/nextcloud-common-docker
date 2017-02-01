#!/usr/bin/with-contenv /bin/sh

set -e

#User params
if [ ! -e '/var/www/html/apps' ]; then
  mkdir -p /var/www/html/apps
  touch /var/www/html/apps/.version
  chown nc-data:nc-data /var/www/html/apps/.version
fi

if [ ! -e '/var/www/html/config' ]; then
  mkdir -p /var/www/html/config
  touch /var/www/html/config/config.sample.php
  chown nc-data:nc-data /var/www/html/config/config.sample.php
fi

if [ ! -e '/var/www/html/data' ]; then
  mkdir -p /var/www/html/data
fi

chown nc-data:nc-data /var/www/html/apps
chown nc-data:nc-data /var/www/html/config
chown nc-data:nc-data /var/www/html/data

if [ ! -e '/var/www/html/version.php' ]; then
  tar cf - -C /usr/src/nextcloud . | tar xf - -C /var/www/html
  cp -p /var/www/html/version.php /var/www/html/apps/.version
fi

if ! diff /var/www/html/version.php /var/www/html/apps/.version >/dev/null ; then
  tar cf - -C /usr/src/nextcloud/apps . | tar xf - -C /var/www/html/apps
  cp -p /var/www/html/version.php /var/www/html/apps/.version
fi

if ! diff /usr/src/nextcloud/config/config.sample.php /var/www/html/config/config.sample.php >/dev/null ; then
  cp -p /usr/src/nextcloud/config/config.sample.php /var/www/html/config/
fi
