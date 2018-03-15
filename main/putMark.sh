#!/bin/bash
echo "===============PUT MARK===============" 1>&2
dir=$(pwd)
w_dir=$1
flag=$(bash "$dir/lookup.sh" "watermark" "$w_dir/gif_settings.txt")
echo "flag:${flag}" 1>&2
if [[ $flag -eq $((1)) ]]; then
    image_mark=$(bash "$dir/lookup.sh" "wmark" "$w_dir/gif_settings.txt")
    echo "image_mark:${image_mark}" 1>&2
    if [[ $image_mark != "" ]]; then
        bash "$dir/fit_wmark.sh" "$w_dir"
        imgList=$(ls -1 $w_dir/images/*.JPG)
        mark_position=$(bash "$dir/lookup.sh" "mark_position" "$w_dir/gif_settings.txt")
        echo "mark_position:${mark_position}" 1>&2
        mark_position=${mark_position:-"SouthEast"}
        #echo "$mark_position" 1>&2
        #echo "$imgList" 1>&2
        for img in $imgList; do
            #echo "${img}" 1>&2
            composite -gravity $mark_position $image_mark "${img}" "${img}"
        done

    fi
fi
echo "=====================================" 1>&2


