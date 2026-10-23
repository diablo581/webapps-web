#!/bin/sh
# The asset CGI scripts call the mysql client without credentials, so give it a
# [client] config pointing at the db container. Written at start from the environment.
set -eu
umask 027
printf "[client]\nhost=%s\nuser=%s\npassword=%s\n" "$DB_HOST" "$DB_USER" "$DB_PASSWORD" > /etc/mysql/conf.d/zz-webapps.cnf
chgrp www-data /etc/mysql/conf.d/zz-webapps.cnf
exec docker-php-entrypoint "$@"
