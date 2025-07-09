#!/bin/bash

# Setup
# sudo apt update && sudo apt upgrade -y
# sudo apt install mariadb-server -y
# sudo systemctl start mariadb
# sudo systemctl enable mariadb

mkdir -p "$(dirname "$0")/backup/src"
mkdir -p "$(dirname "$0")/backup/db"
echo "Backup directory created"

if ! aws s3 ls "s3://limpizza-bucket" > /dev/null 2>&1; then
    aws s3 mb "s3://limpizza-bucket" --region us-east-1
    echo "S3 bucket created"
fi

# Source code & database
git clone https://github.com/LamSut/PizzaGout repo
sudo mysql -u root < repo/backend-api/src/database/pizza.sql
echo "Database initialized"

# Backup script
cat << 'EOF' > backup/backup.sh
#!/bin/bash

# Backup local
tar -czf "$(dirname "$0")/src/src-$(date +%F-%H%M%S).tar.gz" -C "$(dirname "$0")/../repo" .
mysqldump -u root --routines --triggers --all-databases > "$(dirname "$0")/db/db-$(date +%F-%H%M%S).sql"

# Additional upload to S3 (need AWS CLI configured for root user)
aws s3 cp "$(cd "$(dirname "$0")" && pwd)/src/$(ls -t "$(cd "$(dirname "$0")" && pwd)/src" | head -n1)" s3://limpizza-bucket/src/
aws s3 cp "$(cd "$(dirname "$0")" && pwd)/db/$(ls -t "$(cd "$(dirname "$0")" && pwd)/db" | head -n1)" s3://limpizza-bucket/db/
EOF

chmod +x backup/backup.sh
echo "Backup script created"

# Systemd Service & Timer
cat << EOF | sudo tee /etc/systemd/system/backup.service > /dev/null
[Unit]
Description=Run backup script

[Service]
Type=oneshot
WorkingDirectory=$(pwd)
ExecStart=/bin/bash backup/backup.sh
EOF

cat << EOF | sudo tee /etc/systemd/system/backup.timer > /dev/null
[Unit]
Description=Run backup script every hour

[Timer]
OnBootSec=1h
OnUnitActiveSec=1h
Persistent=true

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload
sudo systemctl start backup.timer
sudo systemctl enable --now backup.timer
# sudo systemctl start backup.service
echo "Systemd service and timer created"