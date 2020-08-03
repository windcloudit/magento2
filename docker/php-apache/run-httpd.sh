#!/bin/sh

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*
mkdir -p /run/php-fpm

/usr/sbin/php-fpm -D
exec /usr/sbin/apachectl -DFOREGROUND

# Enable supervisord
