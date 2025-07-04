#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb

git clone https://github.com/LamSut/PizzaGout repo
sudo mysql -u root < repo/backend-api/src/database/pizza.sql
