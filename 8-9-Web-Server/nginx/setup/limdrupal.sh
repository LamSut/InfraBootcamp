#!/bin/bash

# For Ubuntu 24.04 LTS
sudo apt install mariadb-server php8.3 php8.3-fpm php8.3-mysql php8.3-xml php8.3-gd php8.3-mbstring php8.3-curl php8.3-zip php8.3-json php8.3-cli unzip -y
sudo systemctl enable php8.3-fpm
sudo systemctl start php8.3-fpm

sudo systemctl enable mariadb
sudo systemctl start mariadb

sudo mysql -u root <<EOF
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

sudo nginx -t && sudo systemctl reload nginx
