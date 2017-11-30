#!/bin/bash
minidir=$1
wd=$(pwd)

isFbkReq=$(sed '12q;d' "$minidir/gif_settings.txt")
isFbkReq=${isFbkReq:8}

if [ $isFbkReq -eq $((0)) ]; then
    echo "fbk post not required"
else
    echo "posting on fbk ..."

    file_name=$(sed '1q;d' "$minidir/gif_name.txt")

    getMail=$(sed '9q;d' "$minidir/gif_settings.txt")
    getMail=${getMail:7}

    function facebookUpload(){
        bash $wd/edit_fbk.sh $minidir/$file_name $getMail
        php /var/www/html/gif_360_web/server/fbk_upld.php
    }

    if [ -z "$file_name" ]; then
        echo "A file is required"
    else
        echo "Posting ... "
        facebookUpload
        #echo "¡File uploaded!"
    fi
fi
