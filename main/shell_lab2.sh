#!/bin/bash
INPUT=$1
echo "Checking $INPUT directories" 1>&2
#COUNT=$((0))
dir=$(pwd)
gif_dir=$(cat "$dir/chore.list")
#mkdir -p $gif_dir/images
#echo "$gif_dir" 1>&2
#cp $dir/gif_settings.txt $priv_dir
##Number of lines
#LineCount=$(echo "${gif_dir}" | wc -l)
#LineCount=$((LineCount - 1))
#echo "LineCount: $LineCount" 1>&2
#
while read -r line; do
  #COUNT=$((COUNT + 1))
  #echo "$line" 1>&2
  bash "$dir/do_video.sh" "$line"
  sleep 1
  GIFDONE=$(bash "$dir/shell_lab.sh" "$line")
  if [[ $GIFDONE -eq 1 ]]; then
    #echo "$GIFDONE"
    bash "$dir/server_upld.sh" "$line"
    bash "$dir/edit_mail.sh" "$line"
    #bash "$dir/fbk_mnger.sh" "$line"
    tail -n +2 "$gif_dir" > "$dir/chore.list"
  fi
done <<< "${gif_dir}"
