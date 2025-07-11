#!/bin/bash

LOGROTATE_CONF="/etc/logrotate.d/nginx"

cat << 'EOF' | sudo tee "$LOGROTATE_CONF" > /dev/null
/var/log/nginx/*.log {
    # Rotate logs daily
    daily

    # Do not error if the log file is missing
    missingok

    # Keep 30 old log files
    rotate 30

    # Compress old versions of log files with gzip
    compress

    # Delay compression until next rotation
    delaycompress

    # Do not rotate empty logs
    notifempty

    # Create new log file with specific permissions
    create 640 root adm

    # Only run postrotate script once
    sharedscripts

    postrotate
        # Reload Nginx service to apply changes
        if [ -f /var/run/nginx.pid ]; then
            kill -USR1 $(cat /var/run/nginx.pid)
        fi
    endscript
}
EOF

sudo chmod 644 "$LOGROTATE_CONF"

echo "Logrotate configuration for Nginx has been created at $LOGROTATE_CONF"
