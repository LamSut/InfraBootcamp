#!/bin/bash

# Setup
# sudo apt update && sudo apt upgrade -y
# sudo apt install mariadb-server -y
# sudo systemctl start mariadb
# sudo systemctl enable mariadb

# Source code & database
git clone https://github.com/LamSut/PizzaGout repo
sudo mysql -u root < repo/backend-api/src/database/pizza.sql
echo "Database initialized"

# Backup script
mkdir -p backup
cat << 'EOF' > backup/backup.sh
#!/bin/bash

mkdir -p "$(cd "$(dirname "$0")" && pwd)/src"
tar -czf "$(cd "$(dirname "$0")" && pwd)/src/src-$(date +%F-%H%M%S).tar.gz" -C "$(cd "$(dirname "$0")" && pwd)/../repo" .

mkdir -p "$(cd "$(dirname "$0")" && pwd)/db"
mysqldump -u root --routines --triggers --all-databases > "$(cd "$(dirname "$0")" && pwd)/db/db-$(date +%F-%H%M%S).sql"
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
Description=Run backup script every minute

[Timer]
OnBootSec=15s
OnUnitActiveSec=15s
Persistent=true

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload
sudo systemctl start backup.timer
sudo systemctl enable --now backup.timer
sudo systemctl start backup.service
echo "Systemd service and timer created"