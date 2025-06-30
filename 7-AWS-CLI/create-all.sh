#!/bin/bash
set -e  # Stop if any command fails

LOG_FILE="create_log.txt"
> "$LOG_FILE" 

for dir in vpc sg rds ec2 s3; do
  if [ -f "$dir/create.sh" ]; then
    echo "Running $dir/create.sh..." | tee -a "$LOG_FILE"
    bash "$dir/create.sh" >>"$LOG_FILE" 2>&1
  else
    echo "No script found in $dir"
  fi
done
