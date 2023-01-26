#!/bin/bash
set -e

case=$1
#case="java-native-ms"

StackName=$(jq -r ".StackName" "config.json")-$case


#aws cloudformation describe-stacks --stack-name $StackName
aws cloudformation delete-stack --stack-name $StackName
echo "Deleting..."
aws cloudformation wait stack-delete-complete --stack-name $StackName
echo "Stack removed"

#rm -rf sh/.tmp