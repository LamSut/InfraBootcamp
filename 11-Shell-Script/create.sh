#!/bin/bash

# Setup
# sudo apt update && sudo apt upgrade -y
# sudo apt install mariadb-server -y
# sudo systemctl start mariadb
# sudo systemctl enable mariadb

# Source code & database
git clone https://github.com/LamSut/PizzaGout repo
sudo mysql -u root < repo/backend-api/src/database/pizza.sql

# Backup script
cat << 'EOF' > backup.sh
#!/bin/bash

mkdir -p "$(cd "$(dirname "$0")" && pwd)/backup/src"
tar -czf "$(cd "$(dirname "$0")" && pwd)/backup/src/src-$(date +%F-%H%M%S).tar.gz" -C "$(cd "$(dirname "$0")" && pwd)/repo" .

mkdir -p "$(cd "$(dirname "$0")" && pwd)/backup/db"
mysqldump -u root --routines --triggers --all-databases > "$(cd "$(dirname "$0")" && pwd)/backup/db/db-$(date +%F-%H%M%S).sql"
EOF

chmod 755 backup.sh

# Systemd Service & Timer
cat << EOF | sudo tee /etc/systemd/system/backup.service > /dev/null
[Unit]
Description=Run backup script

[Service]
Type=oneshot
ExecStart=/bin/bash $(pwd)/backup.sh
EOF

cat << EOF | sudo tee /etc/systemd/system/backup.timer > /dev/null
[Unit]
Description=Run backup script every minute

[Timer]
OnBootSec=1min
OnUnitActiveSec=1min
Persistent=true

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now backup.timer