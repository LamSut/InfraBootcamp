#!/bin/bash

# Default Apache access log file path
LOG_FILE="/var/log/apache2/access.log"

START_TIME=$1    # Format: HH:MM
END_TIME=$2      # Format: HH:MM
DATE=$3          # Format: DD/Mon/YYYY
TOP_IPS=$4       # Number of top IPs to display
TOP_URLS=$5      # Number of top URLs to display

# Check required args
if [ $# -lt 5 ]; then
  echo "Usage: $0 <start_time> <end_time> <date> <top_ips> <top_urls>"
  echo "Example: $0 13:00 14:00 09/Jul/2025 10 15"
  exit 1
fi

echo "Log file: $LOG_FILE"
echo "Time range: $START_TIME to $END_TIME on $DATE"
echo "Top $TOP_IPS IPs | Top $TOP_URLS URLs"

# Create a temporary file for filtered logs
FILTERED=$(mktemp)

# Filter logs with a specific time range
awk -v date="$DATE" -v start="[$DATE:$START_TIME" -v end="[$DATE:$END_TIME" \
    '$4 >= start && $4 <= end' "$LOG_FILE" > "$FILTERED"

# Display top IP addresses
echo
echo "Top $TOP_IPS IP addresses:"
awk '{print $1}' "$FILTERED" | sort | uniq -c | sort -nr | head -n "$TOP_IPS"

# Display top requested URLs
echo
echo "Top $TOP_URLS requested URLs:"
awk -F\" '{print $2}' "$FILTERED" | awk '{print $2}' | sort | uniq -c | sort -nr | head -n "$TOP_URLS"

# Clean up temporary file
rm "$FILTERED"
