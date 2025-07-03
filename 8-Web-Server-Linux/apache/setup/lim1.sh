sudo mkdir -p /var/www/lim1

sudo chown -R $USER:$USER /var/www/lim1

sudo cp setup/lim1.html /var/www/lim1/

HOSTS_LINE1="127.0.0.1 lim1.com"

if ! grep -q "lim1.com" /etc/hosts; then
    echo "$HOSTS_LINE1" | sudo tee -a /etc/hosts > /dev/null
fi