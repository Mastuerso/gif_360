#!/bin/bash
wd=$(pwd)

isFbkReq=$(sed '12q;d' "$wd/gif_settings.txt")
isFbkReq=${isFbkReq:8}

if [ $isFbkReq -eq $((0)) ]; then
    echo "fbk post not required"
else
    echo "posting on fbk ..."

    file_name=$(sed '1q;d' "$wd/gif_name.txt")

    function serverUpload(){
        bash $wd/server_upld.sh $file_name
    }

    function facebookUpload(){
        bash $wd/edit_fbk.sh $file_name
        php /var/www/html/gif_360_web/server/fbk_upld.php
    }

    if [ -z "$file_name" ]; then
        echo "A file is required"
    else
        echo "Uploading ... "
        serverUpload
        facebookUpload
        #echo "¡File uploaded!"
    fi
fi

