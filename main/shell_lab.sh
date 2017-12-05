#!/bin/bash
dir=$(pwd)
DO=$((1))

while [ $DO -eq $((1)) ]; do
    line=$(sed '1q;d' "$dir/chore.list")
    if [ "$line" == "" ]; then
        echo "Nothing to be done" 1>&2
        exit
    else
        echo "Working on ... $line" 1>&2
        remain=$(awk 'NR>1' $dir/chore.list)
        echo "$remain" > $dir/chore.list
        sed '/^$/d' chore.list > chore.list
        sleep 1s
        exit
    fi    
done



for (( i = 0; i < $LineCount; i++ )); do
  line=$(head -n 1 chore.list)
  bash "$dir/do_video.sh" "$line"
  sleep 5s
  GIFDONE=$(bash "$dir/file_exist.sh" "$line mp4")
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
