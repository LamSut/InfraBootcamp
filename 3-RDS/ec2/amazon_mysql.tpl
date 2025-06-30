#!/bin/bash

# Install MySQL and Cron
sudo dnf install -y https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
curl -O https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
sudo rpm --import RPM-GPG-KEY-mysql-2023
sudo sed -i 's|gpgkey=.*|gpgkey=https://repo.mysql.com/RPM-GPG-KEY-mysql-2023|' /etc/yum.repos.d/mysql-community.repo
sudo dnf clean all
sudo dnf makecache
sudo dnf install -y mysql-community-client
sudo dnf install -y cronie
sleep 60

# Connect and create table
inserts=""
for i in $(seq 1 50); do
  name=$(cat /dev/urandom | tr -dc A-Za-z | head -c 10)
  email="$(cat /dev/urandom | tr -dc a-z | head -c 7)@lamsutdeptraivcl.com"
  inserts+="INSERT INTO test (name, email) VALUES ('$name', '$email');"
done

mysql -h ${endpoint} -u limtruong -plimkhietngoingoi limdb -e "
CREATE TABLE IF NOT EXISTS test (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
$inserts"

# Backup script
echo "#!/bin/bash
mysqldump -h ${endpoint} -u limtruong -plimkhietngoingoi limdb > /home/ec2-user/backup.sql
" > /home/ec2-user/backup.sh

sudo chmod +x /home/ec2-user/backup.sh

# Cron job every minute
echo "* * * * * /home/ec2-user/backup.sh" | crontab -

sudo systemctl enable crond
sudo systemctl start crond
