#!/bin/bash
dir=$(pwd)
DO=$((1))

function remove_line(){
    remain=$(awk 'NR>1' $dir/chore.list)
    echo "$remain" > $dir/chore.list
}

while [ $DO -eq $((1)) ]; do
    line=$(sed '1q;d' "$dir/chore.list")
    if [ "$line" == "" ]; then
        echo "Nothing to be done" 1>&2
        gif_dir=$(cat "$dir/chore.list")
        LineCount=$(echo "${gif_dir}" | wc -l)
        #echo "$LineCount" 1>&2
        if [ $LineCount -gt $((1)) ]; then
            remove_line
        else
            exit
        fi
    else
        echo "Working on ... $line" 1>&2
        #bash "$dir/do_video.sh" "$line"
        GIFDONE=$(bash "$dir/file_exist.sh" "$line" "mp4")
        if [[ $GIFDONE -eq 1 ]]; then
            bash "$dir/server_upld.sh" "$line"
            bash "$dir/edit_mail.sh" "$line"
            bash "$dir/fbk_mnger.sh" "$line"
            remove_line
            #sleep 1s
        else
            remove_line
        fi
    fi    
done