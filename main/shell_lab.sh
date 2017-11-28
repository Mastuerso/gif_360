#!/bin/bash
w_dir=$1
if [ ! -f $w_dir/*.mp4 ]; then
    GIFDONE=$((0))
    echo "$GIFDONE"
  else
    GIFDONE=$((1))
    echo "$GIFDONE"
fi
