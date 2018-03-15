#!/bin/bash
echo "=========CREATE SHARE=========" 1>&2
dir=$(pwd)
DO=$((1))

function remove_minidir(){
    remain=$(awk 'NR>1' $dir/chore.list)
    echo "$remain" > $dir/chore.list
}

while [ $DO -eq $((1)) ]; do
    bash $dir/webNetConn.sh
    minidir=$(sed '1q;d' "$dir/chore.list")
    if [[ "$minidir" == "" ]]; then
        echo "Nothing to be done" 1>&2
        gif_dir=$(cat "$dir/chore.list")
        minidirCount=$(echo "${gif_dir}" | wc -l)
        #echo "$minidirCount" 1>&2
        if [[ $minidirCount -gt $((1)) ]]; then
            remove_minidir
        else
            exit
        fi
    else
        echo "Working on ... $minidir" 1>&2
        GIFDONE=$(bash "$dir/file_exist.sh" "$minidir" "mp4")
        if [[ $GIFDONE -eq $((1)) ]]; then
            email=$(bash $dir/lookup.sh email "${minidir}/gif_settings.txt")
            if [[ $email -eq $((1)) ]]; then
                echo "Uploading and sending mail ..." 1>&2
                bash "$dir/server_upld.sh" "$minidir"
                bash "$dir/php_exe.sh" "mail" "${minidir}"
            fi
            fb_post=$(bash $dir/lookup.sh fb_post "${minidir}/gif_settings.txt")
            if [[ $fb_post -eq $((1)) ]]; then
                echo "Posting on facebook ..." 1>&2
                bash "$dir/php_exe.sh" "facebook" "${minidir}"
            fi
        fi
        remove_minidir
    fi
done
