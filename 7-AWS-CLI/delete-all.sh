#!/bin/bash

LOG_FILE="delete_log.txt"
> "$LOG_FILE"

for dir in s3 ec2 rds sg vpc; do
  if [ -f "$dir/delete.sh" ]; then
    echo "Running $dir/delete.sh..." | tee -a "$LOG_FILE"
    bash "$dir/delete.sh" >>"$LOG_FILE" 2>&1
  else
    echo "No script found in $dir"
  fi
done
