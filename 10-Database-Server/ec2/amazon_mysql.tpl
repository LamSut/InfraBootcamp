#!/bin/bash

# Install MySQL and Cron
sudo dnf install -y https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
curl -O https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
sudo rpm --import RPM-GPG-KEY-mysql-2023
sudo sed -i 's|gpgkey=.*|gpgkey=https://repo.mysql.com/RPM-GPG-KEY-mysql-2023|' /etc/yum.repos.d/mysql-community.repo
sudo dnf clean all
sudo dnf makecache

sudo dnf install -y mysql-community-server mysql-community-client
sudo systemctl enable mysqld
sudo systemctl start mysqld

sudo dnf install -y cronie
sleep 60

# Config MySQL using root
temp_pass=$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
mysql -u root -p"$temp_pass" --connect-expired-password -e "
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Limroot@12345678';

CREATE DATABASE IF NOT EXISTS limdb;

CREATE USER IF NOT EXISTS 'limtruong'@'localhost' IDENTIFIED BY 'Limuser@12345678';
GRANT ALL PRIVILEGES ON limdb.* TO 'limtruong'@'localhost';
FLUSH PRIVILEGES;
"

# Connect and create table
inserts=""
for i in $(seq 1 50); do
  name=$(cat /dev/urandom | tr -dc A-Za-z | head -c 10)
  email="$(cat /dev/urandom | tr -dc a-z | head -c 7)@lamsutdeptraivcl.com"
  inserts+="INSERT INTO test (name, email) VALUES ('$name', '$email');"
done

mysql -u limtruong -pLimuser@12345678 limdb -e "
CREATE TABLE IF NOT EXISTS test (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
$inserts"

# Backup script
echo "#!/bin/bash
mysqldump -u limtruong -pLimuser@12345678 limdb > /home/ec2-user/backup.sql
" > /home/ec2-user/backup.sh

sudo chmod +x /home/ec2-user/backup.sh

# Cron job every minute
echo "* * * * * /home/ec2-user/backup.sh" | crontab -

sudo systemctl enable crond
sudo systemctl start crond
