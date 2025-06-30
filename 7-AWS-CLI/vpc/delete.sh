#!/bin/bash
vpc_id=$(aws ec2 describe-vpcs --filters Name=tag:Name,Values=limtruong-vpc --query 'Vpcs[0].VpcId' --output text)
subnets=$(aws ec2 describe-subnets --filters Name=vpc-id,Values=$vpc_id --query 'Subnets[*].SubnetId' --output text)
for subnet in $subnets; do
  aws ec2 delete-subnet --subnet-id $subnet
done

igw_id=$(aws ec2 describe-internet-gateways --filters Name=attachment.vpc-id,Values=$vpc_id --query 'InternetGateways[0].InternetGatewayId' --output text)
aws ec2 detach-internet-gateway --internet-gateway-id $igw_id --vpc-id $vpc_id
aws ec2 delete-internet-gateway --internet-gateway-id $igw_id

rtb_id=$(aws ec2 describe-route-tables --filters Name=vpc-id,Values=$vpc_id --query 'RouteTables[*].RouteTableId' --output text)
for rtb in $rtb_id; do
  aws ec2 delete-route-table --route-table-id $rtb
done

aws ec2 delete-vpc --vpc-id $vpc_id
