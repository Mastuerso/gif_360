#!/bin/bash
echo "===============NET GIF===============" 1>&2
w_dir=$1
name=$2
dir=$(pwd)
FPS=$(bash $dir/lookup.sh delay $w_dir/gif_settings.txt)
FPS=${FPS:-$((12))}
delay=$((100/$FPS))
echo "delay: ${delay}" 1>&2
mkdir -p "$w_dir/images/net"
cp $w_dir/images/*.JPG $w_dir/images/net/
mogrify -resize 600x400 $w_dir/images/net/*.JPG
convert $w_dir/images/net/*.JPG -delay $delay $w_dir/$2.gif
echo "====================================" 1>&2
