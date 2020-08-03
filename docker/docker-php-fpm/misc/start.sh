#!/bin/sh
# Force migration - Must be changed for production
# Force operation can make data lost
cd /var/www/html

# Start daemon service and bring to background
php artisan cache:clear
php artisan optimize --force

# Create folders
mkdir -p storage/logs
mkdir -p storage/framework/sessions
mkdir -p storage/framework/cache
mkdir -p storage/framework/views
touch storage/logs/laravel.log

# Change permission for writable
chmod 777 -R bootstrap
chmod 777 -R storage
