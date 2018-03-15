#!/bin/bash
userName=$(whoami)
serviceFile=$(echo -e "[Unit]
Description=Gif Creator Service
After=network.target
[Service]
Type=oneshot
User=${userName}
WorkingDirectory=/home/${userName}/gif_360/main/
ExecStart=/home/${userName}/gif_360/main/start_process.sh
SyslogIdentifier=GifCreator
[Install]
WantedBy=multi-user.target
")
#list=$(ls -1 ../)
#echo "${list}"
echo "${serviceFile}" | sudo tee /etc/systemd/system/gif_creator.service