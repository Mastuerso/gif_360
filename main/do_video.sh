#!/bin/bash
echo "=================VIDEO=================" 1>&2
w_dir=$1
dir=$(pwd)
gifnamex=$(date +%b%d_%k%M_%S)
gifname=$(echo ${gifnamex//[[:blank:]]/})
echo "${gifname}.mp4" > $w_dir/gif_name.txt

GIFDONE=$(bash "$dir/file_exist.sh" "$w_dir" "mp4")

if [[ $GIFDONE -ne 1 ]]; then
  #apply calibration params
  python "$dir/apli_calculate_calib.py" $w_dir
  bash $dir/putMark.sh "$w_dir"
  bash $dir/backImg.sh "$w_dir"
  bash $dir/net_gif.sh "$w_dir" "$gifname"
  #bash $dir/vidQuality.sh "$w_dir"
  bash $dir/assembleVid.sh "$w_dir" "$gifname"
fi
