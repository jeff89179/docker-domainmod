FROM php:7.2-apache

RUN docker-php-ext-install pdo_mysql
RUN apt-get update 
RUN apt-get install nano

COPY domainmod/ /var/www/html/
