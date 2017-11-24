#!/bin/bash
w_dir=$(pwd)
box_ready=false
while [[ "$box_ready" == false ]]; do
    echo -n "o" >/dev/ttyACM0
    timeout 0.1 cat </dev/ttyACM0 | tee $file
    line=$(sed '3q;d' $file)
    echo "$line"
    if [[ "$line" == Ready* ]]; then
        box_ready=true
    else
        box_ready=false
    fi
done