# Laravel Dockerized

Docker container template for development with PHP, Composer, Apache and MySQL to create a Laravel project.

## Prerequesites

- Docker
- Docker Compose

## Initial Configurations

### Dockerfile

[OPTIONAL] You can change these variables in Dockerfile:

- USER
- PROJECTNAME

Example:

```
FROM php:7.4-apache

ENV USER johndoe
ENV UID 1000
ENV PROJECTNAME blog
```

[OPTIONAL] You can to enable additional extensions and PHP libraries uncommenting these lines:

```
###################################################################################
#                       OPTIONAL EXTENSIONS AND LIBRARIES                         #
###################################################################################
# RUN echo "Habilitando otimizações no OPcache"
# RUN docker-php-ext-configure opcache --enable-opcache
# RUN docker-php-ext-install opcache
# RUN echo "Instalando e habilitando exif"
# RUN docker-php-ext-configure exif
# RUN docker-php-ext-install exif
# RUN docker-php-ext-enable exif

###################################################################################
#                         Enable Apache ldap auth module                          #
###################################################################################
# RUN echo "Habilitando LDAP"
# RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
# RUN docker-php-ext-install ldap
```

### Docker Compose

If You have changed the PROJECTNAME in Dockerfile then You must change the following lines:

- ./laravel:/var/www/html/laravel

Replace the word 'laravel' for the value of PROJECTNAME.

### initial-configurations.sh

If You have changed the PROJECTNAME in Dockerfile then You must change the following lines:

- projectname="laravel"

Replace the word 'laravel' for the value of PROJECTNAME.

### artisan.sh

If You have changed the PROJECTNAME in Dockerfile then You must change the following lines:

- projectname="/var/www/html/laravel"

Replace the word 'laravel' for the value of PROJECTNAME.

### phpunit.sh

If You have changed the PROJECTNAME in Dockerfile then You must change the following lines:

- projectname="/var/www/html/laravel"

Replace the word 'laravel' for the value of PROJECTNAME.

### 000-default.conf

If You have changed the PROJECTNAME in Dockerfile then You must change the following lines:

- DocumentRoot /var/www/html/laravel/public
- <Directory /var/www/html/laravel>

Replace the word 'laravel' for the value of PROJECTNAME.