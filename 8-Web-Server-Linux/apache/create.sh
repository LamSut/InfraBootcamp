sudo mkdir -p /var/www/lim1
sudo mkdir -p /var/www/lim2

sudo chown -R $USER:$USER /var/www/lim1
sudo chown -R $USER:$USER /var/www/lim2

sudo cp setup/lim1.html /var/www/lim1/
sudo cp setup/lim2.html /var/www/lim2/
sudo cp setup/limsite.conf /etc/apache2/sites-available/limsite.conf

HOSTS_LINE1="127.0.0.1 lim1.com"
HOSTS_LINE2="127.0.0.1 lim2.com"

if ! grep -q "lim1.com" /etc/hosts; then
    echo "$HOSTS_LINE1" | sudo tee -a /etc/hosts > /dev/null
fi

if ! grep -q "lim2.com" /etc/hosts; then
    echo "$HOSTS_LINE2" | sudo tee -a /etc/hosts > /dev/null
fi

sudo a2ensite limsite.conf
sudo systemctl reload apache2

echo "Setup complete!"