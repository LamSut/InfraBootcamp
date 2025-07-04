#!/bin/bash

sudo mkdir -p /var/www/lim2

sudo chown -R $USER:$USER /var/www/lim2

if ! grep -q "lim2.local" /etc/hosts; then
    echo "127.0.0.1 lim2.local" | sudo tee -a /etc/hosts > /dev/null
fi