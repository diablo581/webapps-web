# PHP + Apache image for legacy intranet apps: PHP (gd, pdo_mysql, pdo_sqlite, curl), CGI scripts
# that call the mysql client, and Apache LDAP/AD Basic auth. App code is mounted at runtime.
FROM php:8.4-apache
LABEL org.opencontainers.image.source=https://github.com/diablo581/webapps-web
# ServerName and LDAP settings come from the container environment at runtime.
ENV SERVER_NAME=localhost
RUN apt-get update \
 && apt-get install -y --no-install-recommends libpng-dev libjpeg62-turbo-dev libfreetype6-dev mariadb-client bc \
 && docker-php-ext-configure gd --with-jpeg --with-freetype \
 && docker-php-ext-install -j"$(nproc)" gd pdo_mysql \
 && a2enmod cgid ldap authnz_ldap \
 && rm -rf /var/lib/apt/lists/*
COPY php.ini /usr/local/etc/php/conf.d/zz-webapps.ini
COPY apache.conf /etc/apache2/conf-enabled/zz-webapps.conf
COPY entrypoint.sh /usr/local/bin/webapps-entrypoint
ENTRYPOINT ["webapps-entrypoint"]
CMD ["apache2-foreground"]
