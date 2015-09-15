#!/bin/bash

set -e

# Ubuntu Server 14.04 LTS (HVM), SSD Volume Type
# CUDA won't install on 8GB root drive
id=$(aws ec2 run-instances \
         --image-id ami-d05e75b8 \
         --instance-type g2.2xlarge --count 1 \
         --key-name $1 --security-groups $2 \
         --block-device-mappings file://block-dev-mapping.json \
            |grep InstanceId|sed 's/.*"InstanceId": "\(i-.*\)".*/\1/')
aws ec2 create-tags --resources $id --tags Key=Name,Value=$3
aws ec2 describe-instances --instance-ids $id \
    |grep PublicDnsName|sed 's/.*"PublicDnsName": "\(.*\)".*/\1/'
