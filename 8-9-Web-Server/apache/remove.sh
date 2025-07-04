#!/bin/bash

# For Ubuntu 24.04 LTS
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
# sudo apt purge apache2 mariadb-server php8.3 php8.3-* libapache2-mod-php8.3 -y
# sudo apt autoremove --purge -y

# sudo rm -rf /var/lib/mysql
# sudo rm -rf /etc/mysql

echo "Remove complete!"
