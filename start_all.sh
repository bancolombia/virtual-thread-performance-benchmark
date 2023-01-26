#!/bin/bash

rm -rf .tmp

cases=("elixir-ms" "go-ms" "java-helidon-nima-ms" "java-spring2-ms" "java-spring3-native-ms" "java-spring3-no-native-ms")

for case in "${cases[@]}"; do
  echo "\n\n\nStarting $case"
  ./start.sh "$case"
  ./performance-analyzer.sh "$case"
  ./stop.sh "$case"
done
