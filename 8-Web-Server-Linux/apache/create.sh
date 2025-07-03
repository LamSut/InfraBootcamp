sudo apt update
sudo apt install -y apache2

sudo ./setup/lim1.sh
sudo ./setup/lim2.sh
# sudo ./setup/limdrupal.sh

sudo cp setup/limsite.conf /etc/apache2/sites-available/limsite.conf

sudo a2ensite limsite.conf
sudo a2enmod rewrite
sudo systemctl reload apache2

echo "Setup complete!"