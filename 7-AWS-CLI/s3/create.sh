#!/bin/bash
aws s3api create-bucket --bucket limtruong-cli-bucket --region us-east-1

echo "fbdhsjafbhgjbkzdbvchvb" > test.txt
aws s3 cp test.txt s3://limtruong-cli-bucket/