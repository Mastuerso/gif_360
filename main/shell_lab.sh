#!/bin/bash
dir=$(pwd)
DO=$((1))

while [ $DO -eq $((1)) ]; do
    line=$(sed '1q;d' "$dir/chore.list")
    if [ "$line" == "" ]; then
        echo "Nothing to be done" 1>&2
        gif_dir=$(cat "$dir/chore.list")
        LineCount=$(echo "${gif_dir}" | wc -l)
        #echo "$LineCount" 1>&2
        if [ $LineCount -gt $((1)) ]; then
            remain=$(awk 'NR>1' $dir/chore.list)
            echo "$remain" > $dir/chore.list
        else
            exit
        fi
    else
        echo "Working on ... $line" 1>&2
        bash "$dir/do_video.sh" "$line"
        GIFDONE=$(bash "$dir/file_exist.sh" "$line mp4")
        if [[ $GIFDONE -eq 1 ]]; then
          bash "$dir/server_upld.sh" "$line"
          sleep 5s
          bash "$dir/edit_mail.sh" "$line"
          bash "$dir/fbk_mnger.sh" "$line"
          remain=$(awk 'NR>1' $dir/chore.list)
          echo "$remain" > $dir/chore.list
          sleep 1s
        fi
    fi    
done