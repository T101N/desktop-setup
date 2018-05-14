#!/bin/bash
processes=($(ps aux | grep xboxdrv | awk '{print $2}'))
processCount=${#processes[@]}

echo "Processes: ${processes[*]}"
for (( i = 0; i < processCount-1; i++ )); do
    sudo kill -s 9 ${processes[$i]}
done
