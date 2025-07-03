#!/bin/bash

sudo a2dissite limsite.conf
sudo systemctl reload apache2

sudo rm -rf /var/www/lim1
sudo rm -rf /var/www/lim2
sudo rm -rf /var/www/drupal

sudo rm -f /etc/apache2/sites-available/limsite.conf

sudo sed -i '/lim1\.local/d' /etc/hosts
sudo sed -i '/lim2\.local/d' /etc/hosts
sudo sed -i '/drupal\.local/d' /etc/hosts

# sudo systemctl stop apache2
# sudo systemctl stop mariadb
# sudo apt purge apache2 mariadb-server php php-mysql libapache2-mod-php php-xml php-gd php-mbstring php-curl php-zip php-json php-cli unzip -y
# sudo apt autoremove --purge -y

# sudo systemctl reload apache2
# sudo rm -rf /var/lib/mysql
# sudo rm -rf /etc/mysql

echo "Remove complete!"
