#!/bin/bash
FLAG="false"
while [ "$FLAG" == "false" ]; do
  if [ -e $1  ]; then
    READY=$(lsof $1)
    if [ "$READY" == ""  ]; then
      echo "$1 is Ready"      
      FLAG="true"
    else
      echo "$1 isn't Ready"
      sleep 3s
    fi
  else
    echo "file doesn't exist"
    sleep 3s
  fi
done
