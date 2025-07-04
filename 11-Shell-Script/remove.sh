#!/bin/bash

sudo systemctl stop backup.timer
sudo systemctl disable backup.timer

sudo rm -f /etc/systemd/system/backup.service
sudo rm -f /etc/systemd/system/backup.timer
sudo systemctl daemon-reload

rm -f backup.sh
rm -rf backup/
rm -rf repo

# sudo systemctl stop mariadb
# sudo systemctl disable mariadb
# sudo apt purge --autoremove -y mariadb-server mariadb-common mariadb-client

