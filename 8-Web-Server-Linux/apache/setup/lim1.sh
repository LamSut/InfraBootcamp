sudo mkdir -p /var/www/lim1

sudo chown -R $USER:$USER /var/www/lim1

sudo cp setup/lim1.html /var/www/lim1/

if ! grep -q "lim1.local" /etc/hosts; then
    echo "127.0.0.1 lim1.local" | sudo tee -a /etc/hosts > /dev/null
fi