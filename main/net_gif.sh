#!/bin/bash
dir=$1
name=$2
mkdir -p "$dir/images/net"
cp $dir/images/*.JPG $dir/images/net/
mogrify -resize 600x400 $dir/images/net/*.JPG
convert $dir/images/net/*.JPG -delay 25 $dir/$2.gif
