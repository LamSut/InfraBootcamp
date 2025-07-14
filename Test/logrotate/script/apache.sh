#!/bin/bash

# Commands with full paths
FIND=$(which find)
GZIP=$(which gzip)
MOVE=$(which mv)
TRUNCATE=$(which truncate)
REMOVE=$(which rm)
SYSTEMCTL=$(which systemctl)

LOG_DIR="/var/log/apache2"          # Directory where Apache logs are stored
ACCESS_LOG="$LOG_DIR/access.log"    # Path to the access log
ERROR_LOG="$LOG_DIR/error.log"      # Path to the error log
DATE=$(date +%Y%m%d)                # Current date in YYYYMMDD format

# Remove old compressed logs older than 7 days
$FIND "$LOG_DIR" -type f -name "*.gz" -mtime +7 -exec $REMOVE -f {} \;

# Rotate Apache access logs with gzip compression then truncate the original logs
if [ -s "$ACCESS_LOG" ]; then
    $GZIP -c "$ACCESS_LOG" > "$ACCESS_LOG-$DATE.gz"
    $TRUNCATE -s 0 "$ACCESS_LOG"
fi

# Rotate Apache error logs with gzip compression then truncate the original logs
if [ -s "$ERROR_LOG" ]; then
    $GZIP -c "$ERROR_LOG" > "$ERROR_LOG-$DATE.gz"
    $TRUNCATE -s 0 "$ERROR_LOG"
fi

# Reload Apache to apply changes
$SYSTEMCTL reload apache2

# Remove old compressed logs older than 7 days
$FIND "$LOG_DIR" -type f -name "*.gz" -mtime +7 -exec $REMOVE -f {} \;
