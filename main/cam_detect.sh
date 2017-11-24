#!/bin/bash
#---Detecting cameras---
dir=$(pwd)
while [ $cameras_ready == "false" ]; do
    gphoto2 --auto-detect > cam_list.txt
    file="$dir/cam_list.txt"
    line_count=$((0))
    cam_count=$((0))
    while IFS= read line; do
        line_count=$(( line_count + 1 ))
        if [ $line_count -ge $((3)) ]; then
            cam_count=$(( cam_count + 1 ))
            line=${line:22}
            line="--port="${line//[[:space:]]/}
            cam_port[$cam_count]=$line
        fi
    done <"$file"
    if [ $cam_count -gt $((0)) ]; then
        cameras_ready=true
        echo "$cam_count cameras detected"
        #Sorting cameras
        echo "Sorting cameras, please wait ..."
        count=$((1))
        while [ $count -le $cam_count ]; do
            gphoto2 ${cam_port[$count]} --get-config=ownername > ownername.txt
            file="$dir/ownername.txt"
            linecount=$((0))
            while IFS= read cam_no; do
                linecount=$((linecount + 1))
                if [[ $linecount == $((3)) ]]; then
                    cam_number=${cam_no:12}
                    cam_ordis[${cam_number}]=${cam_port[$count]}
                fi
            done <"$file"
            count=$(( count + 1 ))
        done        
        cameras_no=${#cam_ordis[@]}
        #Normalizing camera order
        for i in "${cam_ordis[@]}"; do
            cameras_no=$(( cameras_no - 1 ))            
            cam_list[$cameras_no]=$i
        done
        echo "${#cam_list[@]} Cameras sorted"
        setup_done=true
        echo -n "r" >/dev/ttyACM0
    else
        echo "Please connect the cameras ..."
        sleep 60
    fi
done