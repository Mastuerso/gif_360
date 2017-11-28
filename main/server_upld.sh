#!/bin/bash
#upload to the server
minidir=$1
file_name=$(sed '1q;d' "$minidir/gif_name.txt")
#HOST=onikom.com.mx
#USER=onikomaws
#PASSWORD=`echo b25pbW92aWw4JQo= | base64 --decode`
#DIR_ADDS=/httpdocs/gif360

HOST=socialevent.mx
USER=marketing@socialevent.mx
PASSWORD='C)i49X2wpThi'
DIR_ADDS=/public_html/gif/uploads/360
echo "Uploading $file_name to server"
local_file="/home/onikom/Pictures/$file_name"
remote_file="$DIR_ADDS/$file_name"
ftp -inv $HOST <<-EOF
    user $USER $PASSWORD
    put $local_file $remote_file
    bye
EOF
