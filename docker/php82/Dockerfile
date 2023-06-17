FROM php:8.2-fpm-alpine3.18

LABEL maintainer="Gergely Gál"

ARG WWWUSER=1000
ARG WWWGROUP=1000

# Install tools and setup www-data user ID
RUN apk add -U shadow
RUN usermod -u $WWWUSER www-data
RUN groupmod -g $WWWGROUP www-data

# Install deployer
COPY deployer.phar /usr/local/bin/dep
RUN chmod +x /usr/local/bin/dep

# Install composer
COPY composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Set custom php.ini
COPY conf.d/php.ini /usr/local/etc/php/conf.d/php.ini