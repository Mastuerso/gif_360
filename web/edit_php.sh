#!/bin/bash
#modify fbk_upload, upload to facebook
gif_name=$1

link_arg="7s/.*/\$link_gif=\"http:\/\/www.onikom.com.mx\/gif360\/${gif_name}.gif\";/"
message_arg="8s/.*/\$message_gif=\"${gif_name}\";/"

#echo $message_arg
#echo $link_arg

sed -i $message_arg fbk_upld.php
sed -i $link_arg fbk_upld.php