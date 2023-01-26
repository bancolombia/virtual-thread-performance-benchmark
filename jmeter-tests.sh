#!/bin/bash
set -e
source ./sh/functions.sh

case=$1
#case="java-native-ms"

mkdir -p .tmp/results-jmeter .tmp/scenarios-jmeter

StackName=$(jq -r ".StackName" "config.json")-$case
User=$(jq -r ".User" "config.json")
Key=$(jq -r ".Key" "config.json")

outputs=$(aws cloudformation describe-stacks --stack-name $StackName | jq '{Outputs: .Stacks[].Outputs}')
app_ip=$(echo $outputs | jq -r '.Outputs[] | select(.OutputKey == "PublicIPApp") | .OutputValue')
app_private_ip=$(echo $outputs | jq -r '.Outputs[] | select(.OutputKey == "PrivateIPApp") | .OutputValue')
tests_ip=$(echo $outputs | jq -r '.Outputs[] | select(.OutputKey == "PublicIPTest") | .OutputValue')

for FILE in test/jmeter/*; do
    name_file=$(basename $FILE);
    scenario=$(basename -s .exs $FILE);

    command="docker restart \$(docker ps -a -q)"
    execute_remote_command "$command" "$app_ip" "$User" "$Key" > /dev/tty

    wait_http "http://$app_ip:8080/"

    cp $FILE ".tmp/scenarios-jmeter/$case-$name_file"
    sed -i -e "s/_SERVICE_IP_/$app_private_ip/g" ".tmp/scenarios-jmeter/$case-$name_file"
    upload_file $tests_ip ".tmp/scenarios-jmeter/$case-$name_file" "JMeterBenchmark.jmx" $User $Key

    echo "------>> $case $scenario" > /dev/tty

    _out=$(execute_remote_command "sudo rm -rf report && sudo rm -f result-jmeter.csv && mkdir -p report" "$tests_ip" "$User" "$Key")
    execute_remote_command "docker run --rm -i -v \${PWD}:\${PWD} -w \${PWD} justb4/jmeter:latest -n -t JMeterBenchmark.jmx -l result-jmeter.csv -e -o report" "$tests_ip" "$User" "$Key" > /dev/tty
    _out=$(execute_remote_command "tar -zcvf report.tar.gz report" "$tests_ip" "$User" "$Key")

    download_file $tests_ip "report.tar.gz" ".tmp/results-jmeter/$scenario-$case.tar.gz" $User $Key
    echo "-------> $case $scenario" > /dev/tty
done

echo "#################"
echo "$case"
echo "#################"
