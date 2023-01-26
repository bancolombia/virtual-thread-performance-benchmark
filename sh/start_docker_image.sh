#!/bin/bash

project=$1
docker stop "$(docker ps -q)"
docker rm -f "$project"

cd app/$project
docker build -t "$project" .

sudo touch /tmp/env.list
docker run --env-file /tmp/env.list --name "$project" -d -p 8080:8080 -p 5432:5432 "$project"
