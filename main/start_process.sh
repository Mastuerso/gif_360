#!/bin/bash
echo "Starting please wait"
dir=$(pwd)
#bash $dir/file_watchdog.sh &
#python $dir/capture.py
nohup bash "$dir/file_watchdog.sh" & nohup python "$dir/capture.py" & nohup bash "$dir/config_watchdog.sh"
