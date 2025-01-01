FROM php:7.4-apache

ENV USER laravel
ENV UID 1000
ENV PROJECTNAME laravel

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u ${UID} -d /home/${USER} ${USER}
RUN mkdir -p /home/${USER}/.composer && chown -R ${USER}:${USER} /home/${USER}

RUN echo "Updating system dependencies"
RUN apt-get update

RUN echo "Installing Linux system dependencies"
RUN apt-get install -y vim g++ libicu-dev libpq-dev libzip-dev zip libbz2-dev zlib1g-dev libldap2-dev curl \
libldb-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev exiftool

RUN echo "Installing and enabling PHP extensions"
RUN docker-php-ext-install bcmath intl mysqli pdo zip bz2
RUN docker-php-ext-configure zip

# Install Xdebug
RUN pecl install xdebug-3.1.6
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini
# XdebugSettings
# $PHP_INI_DIR -> /usr/local/etc/php
RUN echo "xdebug.cli_color=1" >> ${PHP_INI_DIR}/conf.d/xdebug.ini \
 && echo "xdebug.client_host=host.docker.internal" >> ${PHP_INI_DIR}/conf.d/xdebug.ini \
 && echo "xdebug.connect_timeout_ms=5000" >> ${PHP_INI_DIR}/conf.d/xdebug.ini \
 && echo "xdebug.discover_client_host=0" >> ${PHP_INI_DIR}/conf.d/xdebug.ini \
 && echo "xdebug.log=/var/www/xdebug/xdebug.log" >> ${PHP_INI_DIR}/conf.d/xdebug.ini \
 && echo "xdebug.log_level=7" >> ${PHP_INI_DIR}/conf.d/xdebug.ini \
 && echo "xdebug.mode=debug" >> ${PHP_INI_DIR}/conf.d/xdebug.ini \
 && echo "xdebug.client_port=9003" >> ${PHP_INI_DIR}/conf.d/xdebug.ini \
 && echo "xdebug.show_local_vars=1" >> ${PHP_INI_DIR}/conf.d/xdebug.ini \
 && echo "xdebug.start_with_request=yes" >> ${PHP_INI_DIR}/conf.d/xdebug.ini

RUN mkdir -p /var/www/xdebug && \
 touch /var/www/xdebug/xdebug.log && \
 chown $USER:$USER /var/www/xdebug/xdebug.log

################################################ ###############################
# OPTIONAL EXTENSIONS AND LIBRARIES #
################################################ ###############################
# RUN echo "Enabling optimizations in OPcache"
# RUN docker-php-ext-configure opcache --enable-opcache
# RUN docker-php-ext-install opcache
# RUN echo "Installing and enabling exif"
# RUN docker-php-ext-configure exif
# RUN docker-php-ext-install exif
# RUN docker-php-ext-enable exif

################################################ ###############################
# Enable Apache ldap auth module #
################################################ ###############################
# RUN echo "Enabling LDAP"
# RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
# RUN docker-php-ext-install ldap

################################################ ###############################
# Setting Composer #
################################################ ###############################
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

RUN mkdir /var/www/html/${PROJECTNAME}
COPY . /var/www/html/${PROJECTNAME}

WORKDIR /var/www/html/${PROJECTNAME}

COPY ./docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./docker/php/php.ini ${PHP_INI_DIR}
COPY ./docker/initial-configurations.sh /usr/local/bin/initial-configurations
COPY ./docker/phpunit.sh /usr/local/bin/phpunit
COPY ./docker/artisan.sh /usr/local/bin/artisan

RUN chmod +x /usr/local/bin/initial-configurations
RUN chown -R $USER:$USER /usr/local/bin/initial-configurations
RUN chmod +x /usr/local/bin/artisan
RUN chown -R $USER:$USER /usr/local/bin/artisan
RUN chmod +x /usr/local/bin/phpunit
RUN chown -R $USER:$USER /usr/local/bin/phpunit

RUN a2enmod rewrite

USER ${USER}
