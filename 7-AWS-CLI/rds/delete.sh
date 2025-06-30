#!/bin/bash
aws rds delete-db-instance --db-instance-identifier limtruong-db --skip-final-snapshot
sleep 60
aws rds delete-db-subnet-group --db-subnet-group-name limtruong-subnet-group
