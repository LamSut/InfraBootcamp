#!/bin/bash

subnet_id=$(aws ec2 describe-subnets --filters Name=cidr-block,Values=10.0.3.0/24 --query 'Subnets[0].SubnetId' --output text)
sg_id=$(aws ec2 describe-security-groups --filters Name=group-name,Values=limtruong-sg --query 'SecurityGroups[0].GroupId' --output text)

instance_id=$(aws ec2 run-instances \
  --image-id ami-02457590d33d576c3 \
  --instance-type t2.micro \
  --key-name limtruong-pair \
  --subnet-id $subnet_id \
  --security-group-ids $sg_id \
  --associate-public-ip-address \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=limtruong-ec2}]' \
  --query 'Instances[0].InstanceId' --output text)

sleep 10
