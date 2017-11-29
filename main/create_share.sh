#!/bin/bash

dir=$(pwd)
gif_dir=$(cat "$dir/chore.list")

while read -r line; do
  bash "$dir/do_video.sh" "$line"
  sleep 1m  
  GIFDONE=$(bash "$dir/shell_lab.sh" "$line")
  if [[ $GIFDONE -eq 1 ]]; then
    bash "$dir/server_upld.sh" "$line"
    sleep 5
    bash "$dir/edit_mail.sh" "$line"
    #bash "$dir/fbk_mnger.sh" "$line"
    tail -n +2 "$gif_dir" > "$dir/chore.list"
  fi
done <<< "${gif_dir}"
