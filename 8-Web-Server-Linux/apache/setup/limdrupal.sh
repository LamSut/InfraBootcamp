#!/bin/bash

sudo apt clean
sudo apt --fix-broken install -y
sudo apt install -y software-properties-common unzip curl
sudo add-apt-repository -r ppa:ondrej/php -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install -y mariadb-server php8.2 php8.2-mysql php8.2-gd php8.2-dom php8.2-curl php8.2-xml php8.2-mbstring php8.2-zip php8.2-json libapache2-mod-php8.2

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS limdrupal;
CREATE USER 'limtruong'@'localhost' IDENTIFIED BY 'limdrupal@12345678';
GRANT ALL PRIVILEGES ON limdrupal.* TO 'limtruong'@'localhost';
FLUSH PRIVILEGES;
EOF

curl -OL https://www.drupal.org/download-latest/zip
unzip zip
rm -rf /var/www/drupal
mv drupal-* /var/www/drupal
rm zip

sudo chown -R www-data:www-data /var/www/drupal
sudo chmod -R 755 /var/www/drupal

sudo chmod 644 /var/www/drupal/sites/default/default.settings.php
sudo chmod 775 /var/www/drupal/sites/default

if ! grep -q "drupal.local" /etc/hosts; then
    echo "127.0.0.1 drupal.local" >> /etc/hosts
fi
