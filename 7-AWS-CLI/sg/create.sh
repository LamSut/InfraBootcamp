#!/bin/bash

vpc_id=$(aws ec2 describe-vpcs --filters Name=tag:Name,Values=limtruong-vpc --query 'Vpcs[0].VpcId' --output text)
sg_id=$(aws ec2 create-security-group --group-name limtruong-sg --description "limtruong SG" --vpc-id $vpc_id --query 'GroupId' --output text)

aws ec2 authorize-security-group-ingress --group-id $sg_id --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $sg_id --protocol tcp --port 3306 --cidr 10.0.0.0/16