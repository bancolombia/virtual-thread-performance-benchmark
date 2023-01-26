#!/bin/bash
set -e
source ./sh/functions.sh

case=$1
#case="java-native-ms"

mkdir -p .tmp/results .tmp/scenarios

StackName=$(jq -r ".StackName" "config.json")-$case
User=$(jq -r ".User" "config.json")
Key=$(jq -r ".Key" "config.json")

outputs=$(aws cloudformation describe-stacks --stack-name $StackName | jq '{Outputs: .Stacks[].Outputs}')
app_ip=$(echo $outputs | jq -r '.Outputs[] | select(.OutputKey == "PublicIPApp") | .OutputValue')
app_private_ip=$(echo $outputs | jq -r '.Outputs[] | select(.OutputKey == "PrivateIPApp") | .OutputValue')
tests_ip=$(echo $outputs | jq -r '.Outputs[] | select(.OutputKey == "PublicIPTest") | .OutputValue')

for FILE in test/performance-analyzer/*; do
    name_file=$(basename $FILE);
    scenario=$(basename -s .exs $FILE);

    command="docker restart \$(docker ps -a -q)"
    execute_remote_command "$command" "$app_ip" "$User" "$Key" > /dev/tty

    wait_http "http://$app_ip:8080/"

    cp $FILE ".tmp/scenarios/$case-$name_file"
    sed -i -e "s/_IP_/$app_private_ip/g" ".tmp/scenarios/$case-$name_file"
    upload_file $tests_ip ".tmp/scenarios/$case-$name_file" "performance.exs" $User $Key

    echo "------>> $case $scenario" > /dev/tty

    _out=$(execute_remote_command "rm -f result.csv" "$tests_ip" "$User" "$Key")
    execute_remote_command "docker run --rm -v \$(pwd):/app/config bancolombia/distributed-performance-analyzer:0.3.0" "$tests_ip" "$User" "$Key" > /dev/tty

    download_file $tests_ip "result.csv" ".tmp/results/$scenario|$case.csv" $User $Key
    echo "-------> $case $scenario" > /dev/tty
done

echo "#################"
echo "$case"
echo "#################"
