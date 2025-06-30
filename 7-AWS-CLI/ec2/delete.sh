#!/bin/bash
instance_id=$(aws ec2 describe-instances --filters Name=tag:Name,Values=limtruong-ec2 --query 'Reservations[0].Instances[0].InstanceId' --output text)
aws ec2 terminate-instances --instance-ids $instance_id
sleep 20
