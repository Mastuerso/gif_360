#!/bin/bash
wdir=$(pwd)
#get gif width and height
gif_name="$(sed '1q;d' "$wdir/gif_name.txt").gif"
gif_width=`convert $gif_name[0] -format '%w' info:`
gif_height=`convert $gif_name[0] -format '%h' info:` 
echo "the gif\"$gif_name\" size is W:$gif_width x H:$gif_height"

#get watermark width and height
watermark=$(sed '11q;d' "$wdir/gif_settings.txt")
watermark=${watermark:6}
wmark_width=`convert $watermark -format '%w' info:`
wmark_height=`convert $watermark -format '%h' info:` 
echo "the watermark\"$watermark\" size is W:$wmark_width x H:$wmark_height"

#compare theirs w/h

if [ $gif_width -gt $wmark_width ] && [ $gif_height -gt $wmark_height ]; then
    echo "Resizing is not neccesary"
    mv $watermark $wdir/watermark.png
elif [ $gif_width -gt $gif_height ]; then
    echo "Adjusting to gif_height: $gif_height."
    convert $watermark -resize ${gif_height}x${gif_height}\> $wdir/watermark.png
else
    echo "Adjusting to gif_width: $gif_width."
    convert $watermark -resize ${gif_width}x${gif_width}\> $wdir/watermark.png
fi

#if watermark w|h > gif w|h resize watermak to the smallest
#else proceed as intented