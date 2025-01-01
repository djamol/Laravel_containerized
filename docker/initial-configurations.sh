#!/bin/bash
projectname="laravel"

echo "########################################################################################"
echo "#                                                                                      #"
echo "#                           Setting Intial Configurations                              #"
echo "#                                                                                      #"
echo "########################################################################################"
echo ""

echo "Setting user www-data"
printf "chown -R www-data:www-data /var/www/html/%s/" $projectname

if chown -R www-data:www-data /var/www/html/$projectname/
then
    echo "User and group www-data created successful!"
else
    printf "Don't is possible change the configuration of group/user for /var/www/html/%s/" $projectname
    echo "Error: $?"
fi

printf "Setting permissions for /var/www/html/%s/" $projectname
printf "chmod -R 775 /var/www/html/%s/" $projectname

if chmod -R 775 /var/www/html/$projectname/
then
    printf "Permissions for access for /var/www/html/%s/ created successful!" $projectname
else
    printf "Don't is possible change the access for /var/www/html/%s/" $projectname
    echo "Error: $?"
fi

printf "Setting access for /var/www/html/%s/storage/" $projectname
printf "chmod -R 775 /var/www/html/%s/storage/" $projectname

if chmod -R 775 /var/www/html/$projectname/storage/
then
    printf "Permissions for access for /var/www/html/%s/storage/ created successful!" $projectname
else
    printf "Don't is possible change the access for /var/www/html/%s/storage/" $projectname
    echo "Error: $?"
fi

printf "Setting access for /var/www/html/%s/bootstrap/cache/" $projectname
printf "chmod -R 775 /var/www/html/%s/bootstrap/cache/" $projectname

if chmod -R 775 /var/www/html/$projectname/bootstrap/cache/
then
    printf "Permissions for access for /var/www/html/%s/bootstrap/cache/ created successful!" $projectname
else
    printf "Don't is possible change the access for /var/www/html/%s/bootstrap/cache/" $projectname
    echo "Error: $?"
fi

if cd /var/www/html/$projectname
then
    printf "Accessing directory /var/www/html/%s" $projectname
else
    printf "Don't is possible access the directory /var/www/html/%s" $projectname
    echo "Error: $?"
fi

echo "Install Composer"

if composer install
then
    echo "Composer installed successful!"
else
    echo "Don't is possible install the Composer"
    echo "Error: $?"
fi

echo "Creating app key"

if php artisan key:generate
then
    echo "App key created successful!"
else
    echo "Don't is possible create the app key"
    echo "Error: $?"
fi

echo "Cleanning and setting the cache"

if php artisan config:cache
then
    echo "Cache setting successful!"
else
    echo "Don't is possible to clear or to create the cache"
    echo "Error: $?"
fi

echo "Setting the database"

if php artisan migrate
then
    echo "Database setting successful!"
else
    echo "Don't is possible setting the database"
    echo "Error: $?"
fi

echo "Seeding the database"

if php artisan db:seed
then
    echo "The database is ready!"
else
    echo "Don't is possible seeding the database"
    echo "Error: $?"
fi

echo "Setting the link to storage directory"

if php artisan storage:link
then
    echo "storage settings done successful!"
else
    echo "Don't is possible setting the link for storage directory"
    echo "Error: $?"
fi