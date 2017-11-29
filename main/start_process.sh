#!/bin/bash
echo "Starting please wait"
dir=$(pwd)
#bash "$(pwd)/session_manager.sh"
#bash "$(pwd)/system_setup.sh"
#bash $dir/file_watchdog.sh
python $dir/capture.py
