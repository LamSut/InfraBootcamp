# List all log entries from the Apache access log between 13:30 and 14:15 on July 9, 2025
awk '{ match($0, /\[([^ ]+)/, a); if (a[1] >= "09/Jul/2025:13:30:00" && a[1] <= "09/Jul/2025:14:15:00") print }' /var/log/apache2/access.log
