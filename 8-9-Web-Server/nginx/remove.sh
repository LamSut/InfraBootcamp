#!/bin/bash

sudo rm -f /etc/nginx/sites-enabled/drupal.local
sudo rm -f /etc/nginx/sites-enabled/limsite.conf
sudo rm -f /etc/nginx/sites-available/drupal.local
sudo rm -f /etc/nginx/sites-available/limsite.conf
sudo systemctl reload nginx

sudo rm -rf /var/www/lim1
sudo rm -rf /var/www/lim2
sudo rm -rf /var/www/drupal

sudo sed -i '/lim1\.local/d' /etc/hosts
sudo sed -i '/lim2\.local/d' /etc/hosts
sudo sed -i '/drupal\.local/d' /etc/hosts

# sudo systemctl stop nginx
# sudo systemctl stop mariadb
# sudo apt purge nginx mariadb-server php8.3 php8.3-* -y
# sudo apt autoremove --purge -y

# sudo rm -rf /var/lib/mysql
# sudo rm -rf /etc/mysql

echo "Remove complete!"
