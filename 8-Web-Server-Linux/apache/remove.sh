#!/bin/bash

sudo a2dissite limsite.conf
sudo systemctl reload apache2

sudo rm -rf /var/www/lim1
sudo rm -rf /var/www/lim2

sudo rm -f /etc/apache2/sites-available/limsite.conf

sudo sed -i '/lim1\.local/d' /etc/hosts
sudo sed -i '/lim2\.local/d' /etc/hosts
sudo sed -i '/drupal\.local/d' /etc/hosts

echo "Remove complete!"
