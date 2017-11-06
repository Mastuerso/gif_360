#!/bin/bash
file_name=$1
wd=$(pwd)
function serverUpload(){
    bash $wd/server_upld.sh $file_name
}

function facebookUpload(){
    bash $wd/edit_php.sh $file_name
    php fbk_upld.php
}

if [ -z "$file_name" ]; then
    echo "A file is required"
else
    echo "Uploading ... "
    serverUpload
    facebookUpload
    echo "¡File uploaded!"
fi