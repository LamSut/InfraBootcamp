#!/bin/bash

sudo a2dissite limsite.conf
sudo systemctl reload apache2

sudo rm -rf /var/www/lim1
sudo rm -rf /var/www/lim2

sudo rm -f /etc/apache2/sites-available/limsite.conf

sudo sed -i '/127.0.0.1 lim1.com/d' /etc/hosts
sudo sed -i '/127.0.0.1 lim2.com/d' /etc/hosts

echo "Remove complete!"
