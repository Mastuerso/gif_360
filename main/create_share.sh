#!/bin/bash
dir=$(pwd)
gif_dir=$(cat "$dir/chore.list")
LineCount=$(echo "${gif_dir}" | wc -l)

for (( i = 0; i < $LineCount; i++ )); do
  line=$(head -n 1 chore.list)
  bash "$dir/do_video.sh" "$line"  
  sleep 5s
  GIFDONE=$(bash "$dir/shell_lab.sh" "$line")
  if [[ $GIFDONE -eq 1 ]]; then
    bash "$dir/server_upld.sh" "$line"
    sleep 5s
    bash "$dir/edit_mail.sh" "$line"
    bash "$dir/fbk_mnger.sh" "$line"
    remain=$(awk 'NR>1' $dir/chore.list)
    echo "$remain" > $dir/chore.list
  fi
done
sed '/^$/d' chore.list > chore.list
