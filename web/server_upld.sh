#!/bin/bash
#upload to the server
HOST=onikom.com.mx
USER=onikomaws
PASSWORD=`echo b25pbW92aWw4JQo= | base64 --decode`
DIR_ADDS=/httpdocs/gif360
file_name="$1.gif"
echo "Uploading $file_name to server"
local_file="$(pwd)/$file_name"
remote_file="$DIR_ADDS/$file_name"
ftp -inv $HOST <<-EOF
    user $USER $PASSWORD    
    put $local_file $remote_file
    bye
EOF
#rm $local_file

