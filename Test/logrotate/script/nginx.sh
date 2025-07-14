#!/bin/bash

# Commands with full paths
FIND=$(which find)
GZIP=$(which gzip)
TRUNCATE=$(which truncate)
REMOVE=$(which rm)
SYSTEMCTL=$(which systemctl)

LOG_DIR="/var/log/nginx"
ACCESS_LOG="$LOG_DIR/access.log"
ERROR_LOG="$LOG_DIR/error.log"
DATE=$(date +%Y%m%d)

# Remove old compressed logs older than 7 days
$FIND "$LOG_DIR" -type f -name "*.gz" -mtime +7 -exec $REMOVE -f {} \;

# Rotate NGINX access log
if [ -s "$ACCESS_LOG" ]; then
    $GZIP -c "$ACCESS_LOG" > "$ACCESS_LOG-$DATE.gz"
    $TRUNCATE -s 0 "$ACCESS_LOG"
fi

# Rotate NGINX error log
if [ -s "$ERROR_LOG" ]; then
    $GZIP -c "$ERROR_LOG" > "$ERROR_LOG-$DATE.gz"
    $TRUNCATE -s 0 "$ERROR_LOG"
fi

# Reload NGINX to apply changes
$SYSTEMCTL reload nginx

# Remove old compressed logs older than 7 days
$FIND "$LOG_DIR" -type f -name "*.gz" -mtime +7 -exec $REMOVE -f {} \;
