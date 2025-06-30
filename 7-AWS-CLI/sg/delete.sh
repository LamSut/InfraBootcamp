#!/bin/bash
sg_id=$(aws ec2 describe-security-groups --filters Name=group-name,Values=limtruong-sg --query 'SecurityGroups[0].GroupId' --output text)
aws ec2 delete-security-group --group-id $sg_id
