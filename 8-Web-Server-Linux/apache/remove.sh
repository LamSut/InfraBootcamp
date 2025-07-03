#!/bin/bash

sudo a2dissite limsite.conf
sudo systemctl reload apache2

sudo rm -rf /var/www/lim1
sudo rm -rf /var/www/lim2

sudo rm -f /etc/apache2/sites-available/limsite.conf

sudo sed -i '/lim1\.local/d' /etc/hosts
sudo sed -i '/lim2\.local/d' /etc/hosts
sudo sed -i '/drupal\.local/d' /etc/hosts

# sudo apt remove --purge -y apache2 mariadb-server php8.2 php8.2-mysql php8.2-gd php8.2-dom php8.2-curl php8.2-xml php8.2-mbstring php8.2-zip php8.2-json libapache2-mod-php8.2
# sudo apt autoremove --purge -y
# sudo apt clean

echo "Remove complete!"
