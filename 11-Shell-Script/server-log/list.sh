# Search for lines containing the keyword 'systemd' in syslog
awk '/systemd/' /var/log/syslog

# Search for log entries in auth.log that start with timestamp "2025-07-10T09:30"
awk '/^2025-07-10T09:30/' /var/log/auth.log

# List all log entries from the Apache access log between 13:30 and 14:15 on July 9, 2025
awk '{ match($0, /\[([^ ]+)/, a); if (a[1] >= "09/Jul/2025:13:30:00" && a[1] <= "09/Jul/2025:14:15:00") print }' /var/log/apache2/access.log

# Get top 20 IP addresses accessing the Apache server (sorted by frequency)
awk '{print $1}' /var/log/apache2/access.log | sort | uniq -c | sort -nr | head -20

# Get top 20 requested URLs from the Apache access log (sorted by frequency)
awk '{print $7}' /var/log/apache2/access.log | sort | uniq -c | sort -nr | head -20