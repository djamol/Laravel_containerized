#!/bin/bash
projectname="/var/www/html/laravel"

cd $projectname

num=1
for arg in "$*"; do
    php artisan $arg
    ((num++))
done
