sudo apt update && sudo apt upgrade -y
sudo apt install -y nginx

sudo systemctl enable nginx
sudo systemctl start nginx

sudo cp setup/limsite.conf /etc/nginx/sites-available/limsite.conf

sudo ./setup/lim1.sh
sudo cp ../lim1.html /var/www/lim1/

sudo ./setup/lim2.sh
sudo cp ../lim2.html /var/www/lim2/

sudo ./setup/limdrupal.sh

sudo nginx -t && sudo systemctl reload nginx

echo "Setup complete!"
