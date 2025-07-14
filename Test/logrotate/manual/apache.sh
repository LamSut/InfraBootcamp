#!/bin/bash

# Ubuntu 24.04
APACHE_CONF="/etc/apache2/sites-available/000-default.conf"
ROTATELOGS="/usr/bin/rotatelogs"
ACCESS_LOG="/var/log/apache2/access_log.%Y%m%d"
ERROR_LOG="/var/log/apache2/error_log.%Y%m%d"
ROTATE_INTERVAL=86400

# Backup original config
cp "$APACHE_CONF" "${APACHE_CONF}.bak"

# Replace ErrorLog and CustomLog lines
sed -i \
    -e "s#^\s*ErrorLog.*#\tErrorLog \"|$ROTATELOGS $ERROR_LOG $ROTATE_INTERVAL\"#" \
    -e "s#^\s*CustomLog.*#\tCustomLog \"|$ROTATELOGS $ACCESS_LOG $ROTATE_INTERVAL\" combined#" \
    "$APACHE_CONF"

# Reload Apache to apply changes
systemctl reload apache2

echo "Log rotation config updated in $APACHE_CONF."
