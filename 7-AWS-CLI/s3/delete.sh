#!/bin/bash
aws s3 rb s3://limtruong-cli-bucket --force 
# Use --force if the bucket is not empty
