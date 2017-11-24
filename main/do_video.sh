#!/bin/bash
gifname=$(date +"%b%d-%H%M")
w_dir=$(pwd)
FPS=$(sed '1q;d' "$w_dir/gif_settings.txt")
FPS=${FPS:6}
put_MARK=$(sed '10q;d' "$w_dir/gif_settings.txt")
put_MARK=${put_MARK:10}
MARK=$(sed '11q;d' "$w_dir/gif_settings.txt")
MARK=${MARK:6}

echo $gifname.mp4 >gif_name.txt

echo '====================MP4============================'

ffmpeg -framerate $FPS -pattern_type glob -i $w_dir'/images/*.JPG' $w_dir/$gifname.mp4

sleep 2

if [ $put_MARK -eq $((1)) ]; then
    echo '===================WATERMARK================================'
    echo $MARK
    #ffmpeg -i nov13-1635.mp4 -i '/home/onikom/Downloads/marco-gifs.png' -filter_complex "overlay=x=(main_w-overlay_w)/2:y=(main_h-overlay_h)/2" nov13-1635.mp4
    ffmpeg -i $w_dir/$gifname.mp4 -i $MARK -filter_complex "overlay=x=(main_w-overlay_w)/2:y=(main_h-overlay_h)/2" b$gifname.mp4
    rm $w_dir/$gifname.mp4
    mv $w_dir/b$gifname.mp4 $w_dir/$gifname.mp4
fi

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