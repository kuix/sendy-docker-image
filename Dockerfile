FROM php:7.2-apache

## Add MySQL support to container
RUN docker-php-ext-install mysqli gettext && docker-php-ext-enable mysqli gettext

## Enable modrewrite and SSL module
RUN a2enmod rewrite
RUN a2enmod ssl