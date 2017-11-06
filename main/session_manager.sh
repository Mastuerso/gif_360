#!/bin/bash
echo "Session manager"
dir=$(pwd)

file="$dir/nohup.out"
if [ ! -f $file ]; then
    echo "nohup not found!"
else
    rm -f "$dir/nohup.out"
fi
nohup bash "$dir/start_session.sh" & nohup bash "$dir/kill_session.sh"
