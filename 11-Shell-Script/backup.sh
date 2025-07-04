#!/bin/bash

mkdir -p ./backup/src
tar -czf ./backup/src/src-$(date +%F-%H%M%S).tar.gz -C ./repo .

mkdir -p ./backup/db
sudo mysqldump -u root --routines --triggers --all-databases > ./backup/db/db-$(date +%F-%H%M%S).sql
