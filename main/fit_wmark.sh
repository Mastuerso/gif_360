#!/bin/bash
echo '===========FIT WATERMARK===========' 1>&2
w_dir=$1
#echo "${w_dir}"
dir=$(pwd)
#get gif width and height
imgList=$(ls -1 ${w_dir}/images/*.JPG)
for img in $imgList; do
    img_width=`convert $img -format '%w' info:`
    img_height=`convert $img -format '%h' info:`
    break
done
#get watermark width and height
watermark=$(bash "$dir/lookup.sh" "wmark" "$w_dir/gif_settings.txt")
wmark_width=`convert $watermark -format '%w' info:`
wmark_height=`convert $watermark -format '%h' info:`
echo "the watermark\"$watermark\" size is W:$wmark_width x H:$wmark_height" 1>&2

#compare theirs w/h

if [ $img_width -ge $wmark_width ] && [ $img_height -ge $wmark_height ]; then
    echo "Resizing is not neccesary" 1>&2
    #cp $watermark $dir/watermark.png
elif [ $img_width -gt $img_height ]; then
    echo "Adjusting to img_height: $img_height." 1>&2
    #convert $watermark -resize ${img_height}x${img_height}\> $dir/watermark
    mogrify $watermark -resize ${img_height}x${img_height}\> $watermark
else
    echo "Adjusting to img_width: $img_width." 1>&2
    #convert $watermark -resize ${img_width}x${img_width}\> $dir/watermark
    mogrify $watermark -resize ${img_width}x${img_width}\> $watermark
fi

#if watermark w|h > gif w|h resize watermak to the smallest
#else proceed as intented
echo '=============================' 1>&2
