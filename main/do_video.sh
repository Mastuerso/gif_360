#!/bin/bash
gifname=$(date +"%b%d-%H%M")
w_dir=$(pwd)
FPS=$(sed '1q;d' "$w_dir/gif_settings.txt")
FPS=${FPS:6}
put_MARK=$(sed '10q;d' "$w_dir/gif_settings.txt")
put_MARK=${put_MARK:10}

ffmpeg -framerate $FPS -pattern_type glob -i $w_dir'/images/*.JPG' $w_dir/$gifname.mp4
echo $gifname.mp4 >gif_name.txt

if [ $put_MARK -eq $((1)) ]; then
    MARK=$(sed '11q;d' "$w_dir/gif_settings.txt")
    MARK=${put_MARK:6}
    #ffmpeg -i test.mp4 -i watermark.png -filter_complex "overlay=10:10" test1.mp4
    ffmpeg -i $gifname.mp4 -i $MARK -filter_complex "overlay=x=(main_w-overlay_w)/2:y=(main_h-overlay_h)/2" b$gifname.mp4    
    rm $wdir/$gifname.mp4
    mv $wdir/b$gifname.mp4 $wdir/$gifname.mp4
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
echo $gifname