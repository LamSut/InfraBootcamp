#!/bin/bash

sudo systemctl stop backup.timer
sudo systemctl disable backup.timer
sudo rm -f /etc/systemd/system/backup.service
sudo rm -f /etc/systemd/system/backup.timer
sudo systemctl daemon-reload
echo "Backup timer disabled"

sudo rm -rf backup/
rm -rf repo
echo "Backup directory removed"

if aws s3 ls "s3://limpizza-bucket" > /dev/null 2>&1; then
    aws s3 rb "s3://limpizza-bucket" --region us-east-1 --force
    echo "S3 bucket removed"
fi

# sudo systemctl stop mariadb
# sudo systemctl disable mariadb
# sudo apt purge --autoremove -y mariadb-server mariadb-common mariadb-client

