#!/bin/bash
w_dir=$1
if [ ! -f $w_dir/*.gif ]; then
    FILE_EXIST=$((0))
    echo "$FILE_EXIST"
  else
    FILE_EXIST=$((1))
    echo "$FILE_EXIST"
fi
