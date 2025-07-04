#!/bin/bash

# For Ubuntu 24.04 LTS
sudo apt update && sudo apt upgrade -y
sudo apt install -y apache2

sudo systemctl enable apache2
sudo systemctl start apache2

sudo ./setup/lim1.sh
sudo cp ../lim1.html /var/www/lim1/

sudo ./setup/lim2.sh
sudo cp ../lim2.html /var/www/lim2/

sudo ./setup/limdrupal.sh

sudo cp setup/limsite.conf /etc/apache2/sites-available/limsite.conf

sudo a2ensite limsite.conf
sudo a2enmod rewrite
sudo systemctl reload apache2

echo "Setup complete!"