#!/bin/bash
#upload to the server
minidir=$1
dir=$(pwd)
file_name=$(sed '1q;d' "$minidir/gif_name.txt")
#remove mp4 extension
thumb_name="${file_name::-4}"
user_name=$(whoami)

#HOST=onikom.com.mx
#USER=onikomaws
#PASSWORD=`echo b25pbW92aWw4JQo= | base64 --decode`
#DIR_ADDS=/httpdocs/gif360

HOST=$(bash "${dir}/lookup.sh" "HOST" "${dir}/server.config")
USER=$(bash "${dir}/lookup.sh" "USER" "${dir}/server.config")
PASSWORD=$(bash "${dir}/lookup.sh" "PASSWORD" "${dir}/server.config")
DIR_ADDS=$(bash "${dir}/lookup.sh" "DIR_ADDS" "${dir}/server.config")

echo "Uploading $file_name to server"

local_file="$minidir/$file_name"
remote_file="$DIR_ADDS/$file_name"


local_img="$minidir/$thumb_name.gif"
remote_img="$DIR_ADDS/$thumb_name.gif"

#Before uploading check if file already_exist
#probably would be a good idea to create a directory per event

ftp -pinv $HOST <<-EOF
    user $USER $PASSWORD
    put $local_file $remote_file
    put $local_img $remote_img
    bye
EOF
