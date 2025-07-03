sudo mkdir -p /var/www/lim2

sudo chown -R $USER:$USER /var/www/lim2

sudo cp setup/lim2.html /var/www/lim2/

HOSTS_LINE2="127.0.0.1 lim2.com"

if ! grep -q "lim2.com" /etc/hosts; then
    echo "$HOSTS_LINE2" | sudo tee -a /etc/hosts > /dev/null
fi