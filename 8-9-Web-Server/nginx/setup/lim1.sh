#!/bin/bash

sudo mkdir -p /var/www/lim1

sudo chown -R www-data:www-data /var/www/lim1

if ! grep -q "lim1.local" /etc/hosts; then
    echo "127.0.0.1 lim1.local" | sudo tee -a /etc/hosts > /dev/null
fi