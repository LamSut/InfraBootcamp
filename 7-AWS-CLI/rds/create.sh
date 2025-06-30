#!/bin/bash

subnet1=$(aws ec2 describe-subnets --filters Name=cidr-block,Values=10.0.1.0/24 --query 'Subnets[0].SubnetId' --output text)
subnet2=$(aws ec2 describe-subnets --filters Name=cidr-block,Values=10.0.2.0/24 --query 'Subnets[0].SubnetId' --output text)
vpc_id=$(aws ec2 describe-vpcs --filters Name=tag:Name,Values=limtruong-vpc --query 'Vpcs[0].VpcId' --output text)

subnet_group=$(aws rds create-db-subnet-group \
  --db-subnet-group-name limtruong-subnet-group \
  --subnet-ids $subnet1 $subnet2\
  --db-subnet-group-description "limtruong group" \
  --query 'DBSubnetGroup.DBSubnetGroupName' --output text)

aws rds create-db-instance \
  --db-instance-identifier limtruong-db \
  --allocated-storage 10 \
  --db-instance-class db.t3.micro \
  --engine mysql \
  --master-username limtruong \
  --master-user-password limkhietngoingoi \
  --vpc-security-group-ids $(aws ec2 describe-security-groups --filters Name=group-name,Values=limtruong-sg --query 'SecurityGroups[0].GroupId' --output text) \
  --db-subnet-group-name limtruong-subnet-group \
  --no-publicly-accessible

sleep 30
