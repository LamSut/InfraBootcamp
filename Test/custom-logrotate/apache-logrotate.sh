#!/bin/bash

LOGROTATE_CONF="/etc/logrotate.d/apache2"

cat << 'EOF' | sudo tee "$LOGROTATE_CONF" > /dev/null
/var/log/apache2/*.log {
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

    prerotate
        # Run all scripts in /etc/logrotate.d/httpd-prerotate if they exist
        if [ -d /etc/logrotate.d/httpd-prerotate ]; then
            run-parts /etc/logrotate.d/httpd-prerotate
        fi
    endscript

    postrotate
        # Reload Apache2 service to apply changes
        if pgrep -f ^/usr/sbin/apache2 > /dev/null; then
            systemctl reload apache2 > /dev/null 2>&1
        fi
    endscript
}
EOF

sudo chmod 644 /etc/logrotate.d/apache2

echo "Logrotate configuration for Apache2 has been created at $LOGROTATE_CONF"