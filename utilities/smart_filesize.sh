#!/bin/bash
#gif optimization
wdir=$(pwd)
gif=$1
gif_size=$(find $gif -printf "%s" 2>/dev/null)
gif_size=$((gif_size/1000000))
percent=0.94
factor=16
if [ $gif_size -gt $((10)) ]; then
	echo "Reducing file size."
	quality=$(echo $gif_size*$percent | bc -l)
 	quality=$(echo $quality-$factor | bc -l)
	quality=$(echo $quality/$gif_size | bc -l)
	quality=$(echo $((1))-$quality | bc -l)
	quality=$(echo $quality*$((100))| bc -l)
	bash "$wdir/quality_colors.sh" $1 $quality
fi

