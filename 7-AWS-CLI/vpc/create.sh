#!/bin/bash

vpc_id=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)
aws ec2 create-tags --resources $vpc_id --tags Key=Name,Value=limtruong-vpc

igw_id=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
aws ec2 attach-internet-gateway --vpc-id $vpc_id --internet-gateway-id $igw_id

pri1_subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block 10.0.1.0/24 --availability-zone us-east-1a --query 'Subnet.SubnetId' --output text)
pri2_subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block 10.0.2.0/24 --availability-zone us-east-1b --query 'Subnet.SubnetId' --output text)
pub_subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block 10.0.3.0/24 --availability-zone us-east-1a --query 'Subnet.SubnetId' --output text)

aws ec2 create-tags --resources $pri1_subnet_id --tags Key=Name,Value=limtruong-private-subnet-1
aws ec2 create-tags --resources $pri2_subnet_id --tags Key=Name,Value=limtruong-private-subnet-2
aws ec2 create-tags --resources $pub_subnet_id --tags Key=Name,Value=limtruong-public-subnet

rtb_id=$(aws ec2 create-route-table --vpc-id $vpc_id --query 'RouteTable.RouteTableId' --output text)
aws ec2 create-route --route-table-id $rtb_id --destination-cidr-block 0.0.0.0/0 --gateway-id $igw_id
aws ec2 associate-route-table --subnet-id $pub_subnet_id --route-table-id $rtb_id

aws ec2 modify-subnet-attribute --subnet-id $pub_subnet_id --map-public-ip-on-launch
