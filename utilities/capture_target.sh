#!/bin/bash
echo "Capture-Target[config]"
dir=$(pwd)
gphoto2 --auto-detect > "$dir/cam_list.txt"
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
        #echo "${cam_port[$cam_count]}"
    fi
done <"$file"
if [ $cam_count -gt $((0)) ]; then
    echo "$cam_count cameras detected"
    #Sorting cameras
    echo "Configuring cameras, please wait ..."
    count=$((1))
    while [ $count -le $cam_count ]; do
        #echo "Current capturetarget"
        #gphoto2 ${cam_port[$count]} --get-config=capturetarget
        gphoto2 ${cam_port[$count]} --set-config capturetarget=1
        #echo "After config capturetarget"
        gphoto2 ${cam_port[$count]} --get-config=capturetarget
        count=$(( count + 1 ))
    done            
else
    echo "Please connect the cameras ..."
    sleep 10
fi
