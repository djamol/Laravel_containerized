#!/bin/bash
projectname="/var/www/html/laravel"

cd $projectname

num=1
for arg in "$*"; do
    vendor/bin/phpunit --testdox --stop-on-defect $arg
    ((num++))
done
