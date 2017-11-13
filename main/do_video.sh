#!/bin/bash
gifname=$(date +"%b%d-%H%M")
w_dir=$(pwd)
FPS=$(sed '1q;d' "$w_dir/gif_settings.txt")
FPS=${FPS:6}

ffmpeg -framerate $FPS -pattern_type glob -i $w_dir'/images/*.JPG' $w_dir/$gifname.mp4
echo $gifname.mp4 >gif_name.txt


file="$w_dir/results.txt"
box_ready=false
while [[ "$box_ready" == false ]]; do
    echo -n "o" >/dev/ttyACM0
    timeout 0.1 cat </dev/ttyACM0 | tee $file
    line=$(sed '3q;d' $file)
    if [[ "$line" == Ready* ]]; then
        box_ready=true
    else
        box_ready=false
    fi    
done
echo -e "Box Ready\n"
mv "$w_dir/$gifname.mp4" "/home/onikom/Pictures/$gifname.mp4"
echo $gifname